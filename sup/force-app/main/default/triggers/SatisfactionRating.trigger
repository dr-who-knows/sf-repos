trigger SatisfactionRating on Case (after update) {
    if (Trigger.isAfter){
        SatisfactionRatingTriggerHelper.calculateAverageSatisfactionRate(Trigger.New);
    }
}