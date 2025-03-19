//"use strict";
const test = {
    prop: 42,
    func: function () {
      console.log(this === global);
      return this.prop;
    },
  };
 
  console.log(test.func());
  console.log(globalThis);