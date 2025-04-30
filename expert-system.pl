/* clear prolog screen helper */
cls :- write('\33\[2J').

/* Dynamic predicates to store the user responses */
:- dynamic stress/1, screen_time/1, exercise_frequency/1.

/* user response helpers */
/* clear the fact if new response is entered for a given fact*/
save_response(stress, Response) :-
    retractall(stress(_)),
    assertz(stress(Response)).

save_response(screen_time, Response) :-
    retractall(screen_time(_)),
    assertz(screen_time(Response)).

save_response(exercise_frequency, Response) :-
    retractall(exercise_frequency(_)),
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
        write('Response has been saved.'), nl, nl;
        write('Invalid response. Please try again.'), nl,
        fail
    ).

/* Rules */
hcp_value(73.82) :- 
    stress(Stress),
    screen_time(ScreenTime),
    exercise_frequency(ExerciseFrequency),
    Stress =< 5.5,
    ScreenTime =< 6.55,
    (ExerciseFrequency = low; ExerciseFrequency = medium).

hcp_value(64.84) :-
    stress(Stress),
    screen_time(ScreenTime),
    exercise_frequency(ExerciseFrequency),
    Stress =< 5.5,
    ScreenTime =< 6.55,
    ExerciseFrequency = high.

hcp_value(66.38) :-
    stress(Stress),
    screen_time(ScreenTime),
    exercise_frequency(ExerciseFrequency),
    Stress =< 5.5,
    ScreenTime > 6.55,
    (ExerciseFrequency = low; ExerciseFrequency = medium).

hcp_value(56.94) :-
    stress(Stress),
    screen_time(ScreenTime),
    exercise_frequency(ExerciseFrequency),
    Stress =< 5.5,
    ScreenTime > 6.55,
    ExerciseFrequency = high.

hcp_value(65.14) :-
    stress(Stress),
    screen_time(ScreenTime),
    exercise_frequency(ExerciseFrequency),
    Stress > 5.5,
    ScreenTime =< 6.15,
    (ExerciseFrequency = low; ExerciseFrequency = medium).

hcp_value(56.16) :-
    stress(Stress),
    screen_time(ScreenTime),
    exercise_frequency(ExerciseFrequency),
    Stress > 5.5,
    ScreenTime =< 6.15,
    ExerciseFrequency = high.

hcp_value(57.83) :-
    stress(Stress),
    screen_time(ScreenTime),
    exercise_frequency(ExerciseFrequency),
    Stress > 5.5,
    ScreenTime > 6.15,
    (ExerciseFrequency = low; ExerciseFrequency = medium).

hcp_value(47.62) :-
    stress(Stress),
    screen_time(ScreenTime),
    exercise_frequency(ExerciseFrequency),
    Stress > 5.5,
    ScreenTime > 6.15,
    ExerciseFrequency = high.

/* Advice based on cognitive performance score */
score_advice(Score) :-
    Score >= 70,
    write('This score is quite good. Keeping your stress levels and daily screen time low, accompanied with regular exercise is key to maintaining good cognitive performance.').

score_advice(Score) :-
    Score < 70,
    Score >= 60,
    write('This score gives you room for improvement. Consider lowering your screen time and stress levels, along with a balanced exercise regimen to ensure you perform at your best.').

score_advice(Score) :-
    Score < 60,
    Score >= 50,
    write('This score could indicate that you are not performing at your best due to high stress, too much screen time, and moderate to intense exercise. Consider finding ways to destress, reduce screen time, and take some rest days from working out.').

score_advice(Score) :-
    Score < 50,
    write('This score is quite low. We recommend you consider meditation to combat stress levels, lower your time spent staring at screens, and reduce exercise intensity to improve your cognitive performance.').

/* Program driver code */
run_analysis :-
    write('Welcome to the Human Cognitive Perforamance Analysis System!'), nl,
    write('Please answer the following questions so that we can assess your cognitive score.'), nl,
    ask_user('On a scale of 1 to 10, how stressed are you typically?', stress),
    ask_user('Between 1.0 and 12.0, how many hours per day do you spend looking at screens?', screen_time),
    ask_user('What is your general exercise frequency (low, medium, or high)?', exercise_frequency),
    write('Thank you for your responses!'), nl, nl,
    write('Here is a summary of your responses:'), nl,
    write('Stress Level: '), stress(Stress), write(Stress), nl,
    write('Screen Time: '), screen_time(ScreenTime), write(ScreenTime), nl,
    write('Exercise Frequency: '), exercise_frequency(ExerciseFrequency), write(ExerciseFrequency), nl, nl,
    write('...Analyzing your performance metrics...'), nl, nl,
    hcp_value(Score),
    write('Your cognitive performance score is: '), write('.'),
    write(Score), nl, 
    score_advice(Score), nl.


