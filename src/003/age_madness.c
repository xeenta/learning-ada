#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>

/* Two different choices for the type representing the age. */
typedef int age;
typedef unsigned int uage;

const age adult_age = 18;
const uage adult_uage = 18;

const age max_age = 140;
const uage max_uage = 140;

/* these macros should be used wherever we compute an age which is
   supposed to be correct. Assertion can be disabled defining
   NDEBUG. */
#define CHECK(X)  do{assert((X) >= 0 && (X) <= max_age);}while(0)
#define UCHECK(X) do{assert((X) <= max_uage);}while(0)


/*
  The robot interviewer asks how many years ago the subject had the
  first kiss. The code which asks the question and interpret the
  answer isn't shown. Instead, it is given just its result.

  The function shall be called iff the subject already answered Yes to
  the question "Have you ever kissed?"
 */
int get_dist_from_first_kiss(void)
{
    return 56;
}

/* The same as above, but here the software engineer decided to use an
   unsigned int: the event occurred in the past, and we expect a
   positive number of years (in the past).
 */
unsigned int get_abs_dist_from_first_kiss(void)
{
    return 56;
}


age guess_age(void)
{
    /* a complex algorithm to guess the age looking to the subject
       while she answers questions asked by an interviewer.
     */
    return 19; /* she looks so young! */
}


uage guess_uage(void)
{
    /* see above */
    return 19;
}


/*
  This code computes the age of the first kiss basing on the current
  age of the subject and how many years ago she kissed, information
  provided by her (as data it comes from the interpretation of her
  words...)

  These assume that current_age > dist_of_first_kiss.
 */

uage uage_of_kiss(uage current_age)
{
    unsigned int dist_of_first_kiss = get_abs_dist_from_first_kiss();
    UCHECK(current_age - dist_of_first_kiss);
    return current_age - dist_of_first_kiss;
}

age age_of_kiss(age current_age)
{
    int dist_of_first_kiss = get_dist_from_first_kiss();
    CHECK(current_age - dist_of_first_kiss);
    return current_age - dist_of_first_kiss;
}


/* The robot interviewer asks if the subject has ever kissed
    before. For testing purpose, the answer must be yes.
 */
bool have_you_ever_kissed(void)
{
    return true;
}



/*
  The robot asks if she has ever kissed, she answer yes, then the
  robot asks "how many years ago?", and try to compute the age of the
  first kiss using the guesed current age of the subject as starting
  point.

  Because an event in the past can't be occurred in the future, it
  assumes that the (guessed) age is always greater than the number of
  years passed since the first kiss.

  The code doesn't shield itself against lies, and the guess on the
  current age is always trusted.

  A contrived example, but hey...
 */
int main(void)
{
    if (have_you_ever_kissed()) {
        uage first_kiss_uage = uage_of_kiss(guess_uage());
        age first_kiss_age = age_of_kiss(guess_age());
        
        fprintf(stderr, "DEBUG uage of kiss %u\n", first_kiss_uage);

        if (first_kiss_uage < adult_uage) {
            printf("you weren't adult!\n");
        } else {
            printf("so, you waiting for so long...\n");
        }

        fprintf(stderr, "DEBUG age of kiss %d\n", first_kiss_age);

        if (first_kiss_age < adult_age) {
            printf("you weren't adult!\n");
        } else {
            printf("so, you waiting for so long...\n");
        }
    }
    return EXIT_SUCCESS;
}
