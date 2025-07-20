========================
 MAIN PDDL DOMAIN FILE
========================

; File: domain.pddl
; Description: IPC5 Domain for Trucks

; IPC5 Domain: Trucks Propositional
(define (domain Trucks)
(:requirements :typing :disjunctive-preconditions)
(:types truckarea time location locatable - object
        truck package - locatable)
        
(:predicates (at ?x - truck ?l - location)
             (in ?p - package ?t - truck)
             ; (connected ?x ?y - location)
             (connected-clear ?from ?to - location)
             (connected-traffic ?from ?to - location)
             (connected-blocked ?from ?to - location)
             (free ?a - truckarea ?t - truck)
             (time-now ?t - time)
             (next ?t1 - time ?t2 - time)
             (le ?t1 - time ?t2 - time)
             (delivered ?p - package ?l - location ?t - time)
             (at-destination ?p - package ?l - location)
             (closer ?a1 - truckarea ?a2 - truckarea))

(:action load
 :parameters (?p - package ?t - truck ?a - truckarea ?l - location)
 :precondition (and (at ?t ?l) (at ?p ?l) (free ?a ?t))
 :effect (and (not (at ?p ?l)) (not (free ?a ?t)) (in ?p ?t)))

(:action unload
 :parameters (?p - package ?t - truck ?a - truckarea ?l - location)
 :precondition (and (at ?t ?l) (in ?p ?t))
 :effect (and (at ?p ?l) (free ?a ?t) (not (in ?p ?t))))

; (:action drive
; :parameters (?t - truck ?from ?to - location ?t1 ?t2 - time)
; :precondition (and (at ?t ?from) (connected ?from ?to)
; (time-now ?t1) (next ?t1 ?t2))
; :effect (and (not (at ?t ?from)) (at ?t ?to)
; (not (time-now ?t1)) (time-now ?t2)))

(:action drive-clear
 :parameters (?t - truck ?from ?to - Location ?t1 ?t2 - time)
 :precondition (and (at ?t ?from) (connected-clear ?from ?to)
               (time-now ?t1)(next ?t1 ?t2))
 :effect (and (not (at ?t ?from)) (at ?t ?to)
     (not (time-now ?t1)) (time-now ?t2)))

(:action drive-traffic
 :parameters (?t - truck ?from ?to - Location ?t1 ?t3 - time)
 :precondition (and (at ?t ?from) (connected traffic ?from ?to)
     (time-now ?t1)(next ?t1 ?t2) (next ?t2 ?t3)) ; traffic takes 2 steps
 :effect (and (not (at ?t ?from)) (at ?t ?to)
     (not (time-now ?t1)) (time-now ?t3)))

(:action drive-blocked :parameters (?t - truck ?from ?to - Location)
 :precondition (connected-blocked ?from ?to)
 :effect (and) ; no movement occurs
)

(:action deliver
 :parameters (?p - package ?l - location ?t1 ?t2 - time)
 :precondition (and (at ?p ?l) (time-now ?t1) (le ?t1 ?t2))
 :effect (and (delivered ?p ?l ?t2) (at-destination ?p ?l)))
)
