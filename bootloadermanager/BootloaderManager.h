#pragma once

#include <aidl/vendor/volla/bootloadermanager/BnBootmanager.h>

namespace aidl {
namespace vendor {
namespace volla {
namespace bootloadermanager {

class BootloaderManager : public BnBootmanager {
public:
    BootloaderManager();

    // BnPerspective interface
    // ------------------------------------------------------------------------

    virtual ndk::ScopedAStatus uncrypt(const std::string &file, const std::string &map_file,  bool *_aidl_return);
    virtual ndk::ScopedAStatus dmsetup_creat(const std::string &name, const std::string &map_path, bool *_aidl_return);
    virtual ndk::ScopedAStatus dmsetup_remove(const std::string &name, bool *_aidl_return);
    virtual ndk::ScopedAStatus mount(const std::string &device, const std::string &path, bool *_aidl_return);
    virtual ndk::ScopedAStatus umount(const std::string &path, bool *_aidl_return);
    virtual ndk::ScopedAStatus rereadpt(const std::string &device, bool *_aidl_return);

    // ------------------------------------------------------------------------
};

}; // namespace bootloadermanager
}; // namespace volla
}; // namespace vendor
}; // namespace aidl
