//
//  MachMemoryStats.h
//  DeviceInfoViewer
//
//  Created by Matus Tomlein on 14/09/2021.
//

#ifndef MachMemoryStats_h
#define MachMemoryStats_h

@interface MachMemoryStats : NSObject

@property natural_t mem_used;
@property natural_t mem_free;
@property natural_t mem_total;

@end

#endif /* MachMemoryStats_h */
