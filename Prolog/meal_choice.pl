% Meal definitions

meal(carnivorous, tagliatelle_fritte).
meal(carnivorous, lasagna).
meal(carnivorous, tortellini).
meal(carnivorous, spaghetti_allo_scoglio).
meal(carnivorous, carbonara).
meal(vegetarian, salad).
meal(vegetarian, parmigiana).
meal(fish, spaghetti_allo_scoglio).

% Type of food

food_type(Type, Meal) :- meal(Type, Meal).

% Calories level of food

food_calories(Level, salad) :- between(0,2,Level).
food_calories(Level, pizza_margherita) :- between(0,1,Level).
food_calories(Level, tortellini) :- between(0,1,Level).
food_calories(Level, spaghetti_allo_scoglio) :- between(0,1,Level).
food_calories(0, carbonara).
food_calories(0, tagliatelle_fritte).
food_calories(0, lasagna).
food_calories(0, parmigiana).
food_calories(0, tiramisu).

% Calories chosen for a meal


calories_chosen(Level, Meal) :- food_calories(Level, Meal).

% Allergies related to food

food_allergies(gluten_free, salad).
food_allergies(lactose_free, salad).
food_allergies(lactose_free, tortellini).
food_allergies(lactose_free, spaghetti_allo_scoglio).


allergies(AllergiesType, Meal) :- food_allergies(AllergiesType, Meal).

% Guest menu definition

guest_menu(Type, CaloriesLevel, Allergy, Meals) :-
    findall(Meal, 
        ( (Type == none ; food_type(Type, Meal)), 
          calories_chosen(CaloriesLevel, Meal), 
          (Allergy == none ; not(allergies(Allergy, Meal)))), 
        MealsList),
    sort(MealsList, SortedMeals),
    (SortedMeals \= [] -> Meals = SortedMeals ; Meals = none).

% Example queries
% ?- guest_menu(carnivorous, 1, none, Meals).
% ?- guest_menu(vegetarian, 0, none, Meals).
% ?- guest_menu(fish, 1, lactose_free, Meals).
% ?- guest_menu(vegetarian, 1, gluten_free, Meals).
