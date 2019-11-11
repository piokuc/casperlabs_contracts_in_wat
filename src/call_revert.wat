;; This module defines a simple contract that calls CasperLabs FFI function revert.

(module
 
  (type (;0;) (func (param i32)))  ;; type of the revert function
  (type (;1;) (func))              ;; type of the contract's entry point

  ;; Import FFI function revert
  (import "env" "revert" (func $revert (type 0)))

  ;; A memory block is required by Execution Engine, it will error with:
  ;; Fatal PanicInfo { payload: Any, message: Some(Memory section to exist),
  ;; location: Location { file: "src/libcore/option.rs", line: 1166, col: 5 } }
  ;; if missing.
  (memory 0)

  ;; Contract's entry point: always function that takes no parameters
  ;; and has no result.
  (func $call (type 1)
    ;; Call revert(1)
    (call $revert (i32.const 1)))

  ;; Export the function that defines contract, must be called "call"
  (export "call" (func $call))
)
