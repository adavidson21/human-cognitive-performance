/* clear prolog screen helper */
cls :- write('\33\[2J').

/* Dynamic predicates to store the user responses */
:- dynamic stress/1, screen_time/1, exercise_frequency/1.

/* user response helpers */
save_response(stress, Response) :-
    assertz(stress(Response)).

save_response(screen_time, Response) :-
    assertz(screen_time(Response)).

save_response(exercise_frequency, Response) :-
    assertz(exercise_frequency(Response)).

/* Validation functions for each response type */
validate_stress(Response) :-
    integer(Response),
    Response >= 1,
    Response =< 10.

validate_screen_time(Response) :-
    number(Response),
    Response >= 1.0,
    Response =< 12.0.

/* Convert text response to lowercase before comparison */
validate_exercise_frequency(Response) :-
        atom(Response),
        downcase_atom(Response, FormattedResponse),
        member(FormattedResponse, [low, medium, high]).
    

validate_for(stress, Response) :-
    validate_stress(Response).

validate_for(screen_time, Response) :-
    validate_screen_time(Response).

validate_for(exercise_frequency, Response) :-
    validate_exercise_frequency(Response).

/* Ask user for input helper */
ask_user(Question, Metric) :-
    write(Question), nl,
    read(Response),
    (
        validate_for(Metric, Response) ->
        save_response(Metric, Response),
        write('Response has been saved.'), nl;
        write('Invalid response. Please try again.'), nl,
        fail
    ).

run_analysis :-
    write('Welcome to the Human Cognitive Perforamance Analysis System!'), nl,
    write('Please answer the following questions so that we can assess your cognitive score.'), nl,
    ask_user('On a scale of 1 to 10, how stressed are you typically?', stress),
    ask_user('Between 1.0 and 12.0, how many hours per day do you spend looking at screens?', screen_time),
    ask_user('What is your general exercise frequency (low, medium, or high)?', exercise_frequency),
    write('Thank you for your responses!'), nl,
    write('Here is a summary of your responses:'), nl,
    write('Stress Level: '), stress(Stress), write(Stress), nl,
    write('Screen Time: '), screen_time(ScreenTime), write(ScreenTime), nl,
    write('Exercise Frequency: '), exercise_frequency(ExerciseFrequency), write(ExerciseFrequency), nl,
    write('Performing analysis...'), nl.
    

