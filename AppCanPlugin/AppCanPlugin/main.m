//
//  main.m
//  AppCanPlugin
//
//  Created by AppCan on 12-6-5.
//  Copyright (c) 2012年 zywx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WidgetOnePseudoDelegate.h"

#import <dlfcn.h>
#import <sys/types.h>

void anti_gdb_debug();

typedef int (*ptrace_ptr)(int request,pid_t pid,caddr_t addr,void *data);

#if !defined(PT_DENY_ATTACH)
#define PT_DENY_ATTACH 31
#endif

int main(int argc, char *argv[])
{
    
#ifndef  _DEBUG
    anti_gdb_debug();
#endif

    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([WidgetOnePseudoDelegate class]));
    }
}

void anti_gdb_debug(){
    void *handle = dlopen(NULL, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr p_ptr = dlsym(handle, "ptrace");
    p_ptr(PT_DENY_ATTACH,0,0,0);
    dlclose(handle);
}
