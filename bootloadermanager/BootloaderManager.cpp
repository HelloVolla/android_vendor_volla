#include <binder/ParcelFileDescriptor.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <log/log.h>

#include "BootloaderManager.h"

//#if !defined(LOG_NDEBUG) || (LOG_NDEBUG == 0)
#define DEBUG 1
//#else
//#define DEBUG 0
//#endif

#define UNCRYPT_CMD "/system/bin/uncrypt"

namespace aidl {
namespace vendor {
namespace volla {
namespace bootloadermanager {
int call_uncrypt(const char *file_path, const char *status_path) {
    char command[512];

    snprintf(command, sizeof(command), "%s %s %s", UNCRYPT_CMD, file_path, status_path);
    int result = system(command);

    if (result == 0) {
        ALOGE("Uncrypt executed successfully.\n");
//        return 0;
    } else {
        ALOGE("Uncrypt execution failed with error code: %d\n", result);
        return -1;
    }
    snprintf(command, sizeof(command), "/system/bin/chmod 777 %s", status_path);
    result = system(command);
    if (result == 0) {
        ALOGE("chmod executed successfully.\n");
  //      return 0;
    } else {
        ALOGE("chmod execution failed with error code: %d\n", result);
        return -1;
    }
    snprintf(command, sizeof(command), "/system/bin/chown system:system %s", status_path);
    result = system(command);
    if (result == 0) {
        ALOGE("chown executed successfully.\n");
        return 0;
    } else {
        ALOGE("chown execution failed with error code: %d\n", result);
        return -1;
    }

}

int dmsetup_creat_fr(const char *name, const char *map_path) {
    char command[512];
    snprintf(command, sizeof(command), "/system_ext/bin/dmsetup create  %s %s", name, map_path);
    int result = system(command);

    if (result == 0) {
        ALOGE("dmsetup executed successfully.\n");
    } else {
        ALOGE("dmsetup execution failed with error code: %d\n", result);
        return -1;
    }
    snprintf(command, sizeof(command), "/system/bin/chown system:system /dev/block/mapper/%s", name);
    sleep(1);
    result = system(command);
    if (result == 0) {
        ALOGE("chown executed successfully.\n");
        return 0;
    } else {
        ALOGE("chown execution failed with error code: %d\n", result);
        return -1;
    }
}

int dmsetup_remove_fr(const char *name) {
    char command[512];
    snprintf(command, sizeof(command), "/data/user/0/org.andbootmgr.app/cache/tools/Toolkit/dmsetup remove  %s ", name);
    int result = system(command);

    if (result == 0) {
        ALOGE("dmsetup executed successfully.\n");
        return 0;
    } else {
        ALOGE("dmsetup execution failed with error code: %d\n", result);
        return -1;
    }
}

int dmsetup_mount_fr(const char *device, const char *path) {
    char command[512];
sleep(1);
    snprintf(command, sizeof(command), "/system/bin/mount %s %s", device, path);
    int result = system(command);
sleep(1);

    if (result == 0) {
        ALOGE("mount executed successfully.\n");
    } else {
        ALOGE("mount execution failed with error code: %d\n", result);
        return -1;
    }
    snprintf(command, sizeof(command), "/system/bin/chown system:system %s", path);
    result = system(command);
    if (result == 0) {
        ALOGE("chown executed successfully.\n");
        return 0;
    } else {
        ALOGE("chown execution failed with error code: %d\n", result);
        return -1;
    }
}

int dmsetup_umount_fr(const char *path) {
    char command[512];
    snprintf(command, sizeof(command), "/system/bin/umount %s", path);
    int result = system(command);

    if (result == 0) {
        ALOGE("umount executed successfully.\n");
        return 0;
    } else {
        ALOGE("umount execution failed with error code: %d\n", result);
        return -1;
    }
}

int dmsetup_rereadpt_fr(const char *device) {
    char command[512];
sleep(1);
    snprintf(command, sizeof(command), "/system/bin/blockdev --rereadpt %s", device);
    int result = system(command);
sleep(1);

    if (result == 0) {
        ALOGE("rereadpt executed successfully.\n");
    } else {
        ALOGE("rereadpt execution failed with error code: %d\n", result);
        return -1;
    }
    return 0;
}

int copy_fr(const char *src, const char *dst) {
    FILE *in = fopen(src, "rb");
    if (!in) {
        return -1;
    }

    FILE *out = fopen(dst, "wb");
    if (!out) {
        fclose(in);
        return -1;
    }

    char buf[8192];
    size_t n;

    while ((n = fread(buf, 1, sizeof buf, in)) > 0) {
        if (fwrite(buf, 1, n, out) != n) {
            fclose(in);
            fclose(out);
            return -1;
        }
    }

    if (ferror(in)) {
        fclose(in);
        fclose(out);
        return -1;
    }

    fclose(in);
    fclose(out);
    return 0;
}

BootloaderManager::BootloaderManager() {

}

ndk::ScopedAStatus BootloaderManager::uncrypt(const std::string &file, const std::string &map_file, bool *_aidl_return) {
    *_aidl_return = call_uncrypt(file.c_str(), map_file.c_str()) == 0;
    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus BootloaderManager::dmsetup_creat(const std::string &name, const std::string &map_path, bool *_aidl_return) {
    *_aidl_return = dmsetup_creat_fr(name.c_str(), map_path.c_str()) == 0;
    return ndk::ScopedAStatus::ok();
}


ndk::ScopedAStatus BootloaderManager::dmsetup_remove(const std::string &name, bool *_aidl_return) {
    *_aidl_return = dmsetup_remove_fr(name.c_str()) == 0;
    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus BootloaderManager::mount(const std::string &device, const std::string &path, bool *_aidl_return) {
    *_aidl_return = dmsetup_mount_fr(device.c_str(), path.c_str()) == 0;
    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus BootloaderManager::umount(const std::string &path, bool *_aidl_return) {
    *_aidl_return = dmsetup_umount_fr(path.c_str()) == 0;
    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus BootloaderManager::rereadpt(const std::string &device, bool *_aidl_return) {
    *_aidl_return = dmsetup_rereadpt_fr(device.c_str()) == 0;
    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus BootloaderManager::copy(const std::string &src, const std::string &dst, bool *_aidl_return) {
    *_aidl_return = copy_fr(src.c_str(), dst.c_str()) == 0;
    return ndk::ScopedAStatus::ok();
}

} // namespace bootloadermanager
} // namespace volla
} // namespace vendor
} // namespace aidl
