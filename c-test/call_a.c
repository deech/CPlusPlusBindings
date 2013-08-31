#include <stdio.h>
#include <A_C.h>

int main (int argc, char** argv){
  A_static_function();
  _A a = A_new();
  A_member_function(a);
  return 0;
}
