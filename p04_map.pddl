========================
 MAIN PDDL Problem 04
========================

(define (problem problem_map4)
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
        ;; Map4- road connections
        (connected-clear m1 m2)
        (connected-clear m2 m1)
        (connected-clear m1 m3)
        (connected-clear m3 m1)
        (connected-clear m1 m4)
        (connected-traffic m4 m1)
        (connected-clear m2 m3)
        (connected-clear m3 m2)
        (connected-clear m2 m4)
        (connected-clear m4 m2)
        (connected-clear m3 m4)
        (connected-clear m4 m3)
        (connected-clear m2 m5)
        (connected-clear m5 m2)
        (connected-clear m5 m1)
        (connected-clear m1 m5)
        (connected-clear m4 m6)
        (connected-clear m6 m4)
        (connected-clear m6 m1)
        (connected-clear m1 m6)
        (connected-clear m3 m7)
        (connected-clear m7 m3)
        (connected-clear m7 m1)
        (connected-clear m1 m7)

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
        (le t2 t2)
        (le t2 t3)
        (le t2 t4)
        (le t2 t5)
        (le t2 t6)
        (le t2 t7)
        (le t2 t8)
        (le t2 t9)
        (le t2 t10)
        (le t3 t3)
        (le t3 t4)
        (le t3 t5)
        (le t3 t6)
        (le t3 t7)
        (le t3 t8)
        (le t3 t9)
        (le t3 t10)
        (le t4 t4)
        (le t4 t5)
        (le t4 t6)
        (le t4 t7)
        (le t4 t8)
        (le t4 t9)
        (le t4 t10)
        (le t5 t5)
        (le t5 t6)
        (le t5 t7)
        (le t5 t8)
        (le t5 t9)
        (le t5 t10)
        (le t6 t6)
        (le t6 t7)
        (le t6 t8)
        (le t6 t9)
        (le t6 t10)
        (le t7 t7)
        (le t7 t8)
        (le t7 t9)
        (le t7 t10)
        (le t8 t8)
        (le t8 t9)
        (le t8 t10)
        (le t9 t9)
        (le t9 t10)
        (le t10 t10)



        (next t0 t1)
        (next t1 t2)
        (next t2 t3)
        (next t3 t4)
        (next t4 t5)
        (next t5 t6)
        (next t6 t7)
        (next t7 t8)
        (next t8 t9)
        (next t9 t10))

(:goal (and
       (delivered package1 m3 t5)
       (delivered package2 m1 t7)
       (delivered package3 m1 t7)
       (delivered package4 m2 t7)))


)
