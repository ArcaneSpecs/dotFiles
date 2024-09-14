#pragma one

#include <iostream>

#define BASE_DAMAGE 90

#define GAME_CONFIG 1
#if GAME_CONFIG == 1
    // INFO: Only for development
    // #define LOG_ERROR(msg) printf("ERROR: %s\n", msg)
    #define LOG_ERROR(msg) std::cout << "ERROR: " << msg << "\n"
    #define LOG_INFO(msg) printf("INFO: %s\n", msg)
#else
    // INFO: Strip the error logs in release build
    #define LOG_ERROR(msg) 
#endif

