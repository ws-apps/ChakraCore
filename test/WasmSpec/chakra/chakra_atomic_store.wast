(module
  ;; todo make this a shared memory
  (memory 1)

  (func (export "store") (param i32 i64) (result i32)
    (i64.atomic.store offset=15 (get_local 0) (get_local 1))
    (i32.atomic.load offset=19 (get_local 0))
  )
)

(assert_return (invoke "store" (i32.const 1)  (i64.const 0xffffffff41ce0000)) (i32.const 0xffffffff))
(assert_return (invoke "store" (i32.const 9)  (i64.const 0x78563412ffffffff)) (i32.const 0x78563412))
(assert_trap (invoke "store" (i32.const 0)  (i64.const 0)) "atomic memory access is unaligned")
(assert_trap (invoke "store" (i32.const 2)  (i64.const 0)) "atomic memory access is unaligned")
(assert_trap (invoke "store" (i32.const 3)  (i64.const 0)) "atomic memory access is unaligned")
(assert_trap (invoke "store" (i32.const 4)  (i64.const 0)) "atomic memory access is unaligned")
(assert_trap (invoke "store" (i32.const 5)  (i64.const 0)) "atomic memory access is unaligned")
(assert_trap (invoke "store" (i32.const 6)  (i64.const 0)) "atomic memory access is unaligned")
(assert_trap (invoke "store" (i32.const 7)  (i64.const 0)) "atomic memory access is unaligned")
(assert_trap (invoke "store" (i32.const 8)  (i64.const 0)) "atomic memory access is unaligned")
(assert_trap (invoke "store" (i32.const 10) (i64.const 0)) "atomic memory access is unaligned")
(assert_trap (invoke "store" (i32.const 11) (i64.const 0)) "atomic memory access is unaligned")
(assert_trap (invoke "store" (i32.const 12) (i64.const 0)) "atomic memory access is unaligned")
(assert_trap (invoke "store" (i32.const 13) (i64.const 0)) "atomic memory access is unaligned")
(assert_trap (invoke "store" (i32.const 14) (i64.const 0)) "atomic memory access is unaligned")

(assert_return (invoke "store" (i32.const 65513) (i64.const 0x78563412ffffffff)) (i32.const 0x78563412))
(assert_trap (invoke "store" (i32.const 65521) (i64.const 0)) "out of bounds memory access")