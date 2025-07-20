========================
 MAIN PDDL Problem 02
========================

(define (problem problem_map2)
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
        a1 - truckarea
        a2 - truckarea)

(:init
        (at truck1 m2)
        (free a1 truck1)
        (free a2 truck1)
        (closer a1 a2)

        ;; package locations
        (at package1 m1)
        (at package2 m3)
        (at package3 m4)
        (at package4 m7)

        ;; Map2 road connections
        (connected-clear m2 m3)
        (connected-clear m3 m2)
        (connected-clear m2 m4)
        (connected-clear m4 m2)
        (connected-clear m3 m1)
        (connected-clear m1 m3)
        (connected-clear m4 m1)
        (connected-clear m1 m4)
        (connected-clear m4 m7)
        (connected-traffic m7 m4)
        (connected-clear m7 m3)
        (connected-blocked m3 m7)
        (connected-clear m3 m5)
        (connected-clear m5 m3)
        (connected-clear m5 m6)
        (connected-clear m6 m5)
        (connected-clear m6 m2)
        (connected-clear m2 m6)

        ;; time progress
        (time-now t0)
        (le t1 t1)
        (le t1 t2)
        (le t1 t3)
        (le t1 t4)
        (le t1 t5)
        (le t1 t6)
        (le t1 t7)
        (le t1 t8)
        (le t1 t9)
        (le t1 t10)
        (le t1 t11)
        (le t1 t12)
        (le t1 t13)
        (le t1 t14)
        (le t1 t15)
        (le t2 t2)
        (le t2 t3)
        (le t2 t4)
        (le t2 t5)
        (le t2 t6)
        (le t2 t7)
        (le t2 t8)
        (le t2 t9)
        (le t2 t10)
        (le t2 t11)
        (le t2 t12)
        (le t2 t13)
        (le t2 t14)
        (le t2 t15)
        (le t3 t3)
        (le t3 t4)
        (le t3 t5)
        (le t3 t6)
        (le t3 t7)
        (le t3 t8)
        (le t3 t9)
        (le t3 t10)
        (le t3 t11)
        (le t3 t12)
        (le t3 t13)
        (le t3 t14)
        (le t3 t15)
        (le t4 t4)
        (le t4 t5)
        (le t4 t6)
        (le t4 t7)
        (le t4 t8)
        (le t4 t9)
        (le t4 t10)
        (le t4 t11)
        (le t4 t12)
        (le t4 t13)
        (le t4 t14)
        (le t4 t15)
        (le t5 t5)
        (le t5 t6)
        (le t5 t7)
        (le t5 t8)
        (le t5 t9)
        (le t5 t10)
        (le t5 t11)
        (le t5 t12)
        (le t5 t13)
        (le t5 t14)
        (le t5 t15)
        (le t6 t6)
        (le t6 t7)
        (le t6 t8)
        (le t6 t9)
        (le t6 t10)
        (le t6 t11)
        (le t6 t12)
        (le t6 t13)
        (le t6 t14)
        (le t6 t15)
        (le t7 t7)
        (le t7 t8)
        (le t7 t9)
        (le t7 t10)
        (le t7 t11)
        (le t7 t12)
        (le t7 t13)
        (le t7 t14)
        (le t7 t15)
        (le t8 t8)
        (le t8 t9)
        (le t8 t10)
        (le t8 t11)
        (le t8 t12)
        (le t8 t13)
        (le t8 t14)
        (le t8 t15)
        (le t9 t9)
        (le t9 t10)
        (le t9 t11)
        (le t9 t12)
        (le t9 t13)
        (le t9 t14)
        (le t9 t15)
        (le t10 t10)
        (le t10 t11)
        (le t10 t12)
        (le t10 t13)
        (le t10 t14)
        (le t10 t15)
        (le t11 t11)
        (le t11 t12)
        (le t11 t13)
        (le t11 t14)
        (le t11 t15)
        (le t12 t12)
        (le t12 t13)
        (le t12 t14)
        (le t12 t15)
        (le t13 t13)
        (le t13 t14)
        (le t13 t15)
        (le t14 t14)
        (le t14 t15)
        (le t15 t15)
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
)

(:goal (and
        (delivered package1 m3 t6)
        (delivered package2 m1 t15)
        (delivered package3 m1 t12)
        (delivered package4 m2 t12)))
)
