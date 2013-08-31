#include "A_C.h"

FL_EXPORT_C(void, A_static_function)(){
  A::static_function();
}
FL_EXPORT_C(void, A_member_function)(_A a){
  (static_cast<A*>(a))->member_function();
}
FL_EXPORT_C(_A, A_new)(){
  A* a = new A();
  return (_A)a;
}
