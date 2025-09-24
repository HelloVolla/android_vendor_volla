#include <sys/types.h>
#include <sys/stat.h>

#include <utils/Log.h>

#include <android/binder_manager.h>
#include <android/binder_process.h>

#include "BootloaderManager.h"

using aidl::vendor::volla::bootloadermanager::BootloaderManager;

#define SERVICE_NAME "bootloadermanager"

int main(void) {
    umask(0000);
    auto perspective = ndk::SharedRefBase::make<BootloaderManager>();

    binder_status_t status = AServiceManager_addService(perspective->asBinder().get(), SERVICE_NAME);
    if (status != STATUS_OK) {
        ALOGE("Could not register perspective binder service");
        return EXIT_FAILURE;
    }

    ABinderProcess_joinThreadPool();

    // should never get here
    return EXIT_FAILURE;
}
