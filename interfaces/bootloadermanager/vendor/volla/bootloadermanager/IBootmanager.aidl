
package vendor.volla.bootloadermanager;

/**
 * @hide
 */
interface IBootmanager {
    boolean uncrypt(String file, String map_file);
    boolean dmsetup_creat(String name, String map_path);
    boolean dmsetup_remove(String name);
    boolean mount(String device, String path);
    boolean umount(String path);
}
