(define (problem problem_map9)
(:domain Trucks)

(:objects
        truck1 - truck
        package1 - package
        package2 - package
        package3 - package
        package4 - package
        m1 - location
        m2 - location
        m3 - location
        m4 - location
        m5 - location
        m6 - location
        m7 - location
        City1 - location
        t0 - time
        t1 - time
        t2 - time
        t3 - time
        t4 - time
        t5 - time
        t6 - time
        t7 - time
        t8 - time
        t9 - time
        t10 - time
        t11 - time
        t12 - time
        t13 - time
        t14 - time
        t15 - time
        t16 - time
        t17 - time
        t18 - time
        t19 - time
        t20 - time
        a1 - truckarea
        a2 - truckarea)

(:init
        (at truck1 m1)
        (free a1 truck1)
        (free a2 truck1)
        (closer a1 a2)

        ;; package locations
        (at package1 m1)
        (at package2 m3)
        (at package3 m4)
        (at package4 m7)

        ;; Map9 - road connections
        (connected-clear m1 m2)
        (connected-clear m2 m3)
        (connected-clear m3 m2)
        (connected-clear m3 m4)
        (connected-clear m4 m3)
        (connected-clear m4 m5)
        (connected-clear m5 m4)
        (connected-clear m5 m6)
        (connected-clear m6 m5)
        (connected-clear m6 m7)
        (connected-clear m7 m6)
        (connected-clear m7 m1)
        (connected-clear m1 m7)
        (connected-clear m2 m5)
        (connected-clear m5 m2)
        (connected-clear m3 m6)
        (connected-clear m6 m3)
        (connected-clear m4 m1)
        (connected-clear m1 m4)
        (connected-clear m5 m3)
        (connected-clear m3 m5)
        (connected-clear m1 m6)
        (connected-clear m6 m1)
        (connected-clear m2 m6)
        (connected-clear m6 m2)
        (connected-clear m4 m2)
        (connected-clear m2 m4)
        (connected-clear m3 m1)
        (connected-clear m1 m3)
        (connected-clear m2 m7)
        (connected-clear m7 m2)
        (connected-clear m6 m4)
        (connected-clear m4 m6)
        (connected-clear m5 m7)
        (connected-clear m7 m5)

        ;; time progression
        (time-now t0)
        (le t1 t1)
        (le t1 t2)
        (le t1 t3)
        (le t1 t4)
        (le t1 t5)
        (le t1 t6)
        (le t2 t2)
        (le t2 t3)
        (le t2 t4)
        (le t2 t5)
        (le t2 t6)
        (le t3 t3)
        (le t3 t4)
        (le t3 t5)
        (le t3 t6)
        (le t4 t4)
        (le t4 t5)
        (le t4 t6)
        (le t5 t5)
        (le t5 t6)
        (le t6 t6)
        (le t6 t7)
        (le t7 t7)
        (le t7 t8)
        (le t8 t9)
        (le t9 t9)
        (le t9 t10)
        (le t10 t11)
        (le t11 t12)
        (le t12 t13)
        (le t13 t14)
        (le t14 t15)
        (le t15 t16)
        (le t16 t17)
        (le t17 t18)
        (le t18 t19)
        (le t19 t20)

        (next t0 t1)
        (next t1 t2)
        (next t2 t3)
        (next t3 t4)
        (next t4 t5)
        (next t5 t6)
        (next t6 t7)
        (next t7 t8)
        (next t8 t9)
        (next t9 t10)
        (next t10 t11)
        (next t11 t12)
        (next t12 t13)
        (next t13 t14)
        (next t14 t15)
        (next t15 t16)
        (next t16 t17)
        (next t17 t18)
        (next t18 t19)
        (next t19 t20))

(:goal (and
        (delivered package1 m3 t4)
        (delivered package2 m1 t6)
        (delivered package3 m1 t5)
        (delivered package4 m2 t20)))
)
