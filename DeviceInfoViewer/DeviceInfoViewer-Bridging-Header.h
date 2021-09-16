//
//  DeviceInfoViewer-Bridging-Header.h
//  DeviceInfoViewer
//
//  Created by Matus Tomlein on 09/09/2021.
//

#ifndef DeviceInfoViewer_Bridging_Header_h
#define DeviceInfoViewer_Bridging_Header_h

#import <os/proc.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#include <Foundation/Foundation.h>
#import "MachMemoryStats.h"
#include <sys/mount.h>


long statfsFree(const char *path) {
    struct statfs tStats;
    if (statfs(path, &tStats) == 0) {
        return tStats.f_bavail * tStats.f_bsize;
    }
    return -1;
}

long statfsTotal(const char *path) {
    struct statfs tStats;
    if (statfs(path, &tStats) == 0) {
        return tStats.f_blocks * tStats.f_bsize;
    }
    return -1;
}

MachMemoryStats * getMachMemoryStats()
{
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;

    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);

    vm_statistics_data_t vm_stat;

    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        NSLog(@"Failed to fetch vm statistics");
    }

    /* Stats in bytes */
    natural_t mem_used = (vm_stat.active_count +
                          vm_stat.inactive_count +
                          vm_stat.wire_count) * pagesize;
    natural_t mem_free = vm_stat.free_count * pagesize;
    natural_t mem_total = mem_used + mem_free;

    NSLog(@"used: %u free: %u total: %u", mem_used, mem_free, mem_total);

    MachMemoryStats *stats = [[MachMemoryStats alloc] init];
    stats.mem_free = mem_free;
    stats.mem_total = mem_total;
    stats.mem_used = mem_used;
    return stats;
}

#endif /* DeviceInfoViewer_Bridging_Header_h */
