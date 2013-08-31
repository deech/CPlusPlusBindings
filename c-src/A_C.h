#ifndef __A_C__
#define __A_C__

#ifdef EXPORT
#undef EXPORT
#endif
#define EXPORT extern "C"

#ifdef __WATCOMC__
  #include <windows.h>
  #define FL_EXPORT_C(TYPE,FUNC_NAME) TYPE __export __cdecl FUNC_NAME
#else
  #ifdef _WIN32
    #define FL_EXPORT_C(TYPE,FUNC_NAME) __declspec(dllexport) TYPE __cdecl FUNC_NAME
    #undef EXPORT
    #define EXPORT extern "C" __declspec(dllexport)
  #else
    #define FL_EXPORT_C(TYPE,FUNC_NAME) TYPE FUNC_NAME
  #endif
  #ifndef _cdecl
    #define _cdecl
  #endif
#endif

#ifdef __cplusplus
#include <A.h>
EXPORT {
#endif
typedef void* _A;
  FL_EXPORT_C(void, A_static_function)();
  FL_EXPORT_C(void, A_member_function)(_A a);
  FL_EXPORT_C(_A,   A_new)();
typedef enum { HELLO, WORLD } hello_world;
#ifdef __cplusplus
}
#endif
#endif /* __A_C__ */
