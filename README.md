# CIS 350 Project

## Dinner Planner App

## Made by

---

### Nathan Barber

### Rylan Bernhardt

---

## Important Links

 ----
 
### JIRA

<https://mail-team-otacijvt.atlassian.net/jira/software/projects/C3P/boards/2?atlOrigin=eyJpIjoiN2IzZmNkY2E5NmYzNDdhMTg2YWI1NzQ3MWYxYjg2ZjciLCJwIjoiaiJ9>

### GITHUB

<https://github.com/Rjbern/CIS-350-Project>

---

## 1. Abstract

Eating is a part of daily life for all people. We need food to keep our minds and bodies alive and when life gets busy with work, family, school, and other life events finding time to schedule what meals you will eat on what days and what ingredients you need for those can be a big time commitment. This can cause people to skip meals or stop at fast food restaurants due to a lack of organization and time. These both are unhealthy. The idea of the “**Dinner Planner**” is to allow people to mitigate the time-consuming, and sometimes stress-inducing process of meal planning and grocery shopping. The user will be able to add the meal of choice to the day they want to plan it and add the items needed for that meal. The App then will plan the meal for the user and add the items to their list. This will help organize the user's life in an area that gets neglected at times. Food has a big impact on health and allows users to organize and plan what they eat and when can allow them to make better choices for their health.

## 2. Introduction

Flutter allows for the development of mobile applications that can be used across multiple mobile operating systems. This allows for “**Dinner Planner**” to reach most people. Life can get busy pressuring people to make bad eating habits that can affect health negatively. Most people now have mobile devices allowing for the process of organizing their lives to be much easier and less time-consuming. If the user has one of these devices, they will be able to plan their meals and groceries whenever the get the chance so they do not have to make last-minute decisions. After installing “**Dinner Planner**” users will be able to see a calendar of the current week as well as a place to schedule a meal for all seven days of any week.  The users will be able to add or remove custom recipes to the list of possible recipes to schedule.  One recipe can be placed per day in order to plan the upcoming meals.  On another page, the user will be able to see a comprehensive list of groceries needed in order to prepare a given weeks worth of meals.

## 3. Architectural Design

"**Dinner Planner**" was designed around a singluar client side interface.  This means that all storage of data is housed on device. A risk analysis was done in order to decide to go with the architecture shown in Figure 1.

<p align="center">
  <img src="./readmeFigures/architectureDesign.PNG" width="300" title="architecture">
  <br>
  Figure 1: Client and Storage Architecture
</p>

This architecture design allows a singular user to keep all their data stored on device so no internet connection is needed to run the app.  Additionally, there is no chance that a sever disruption could hinder the user using the app.  Two downsides to this design that were considered were multi-device support and having a backup if the users device were to get damaged.  For the short timeline of this project the simplicity of not having a server made the most sense because the two main issues were more long term itteration changes.

### 3.1 Class Diagram

<p align="center">
  <img src="./readmeFigures/classDiagram.PNG" width="700" title="classDiagram">
  <br>
  Figure 2: Class Diagram
</p>

### 3.2 Use Case Diagram

Major uses of the "**Diner Planner**" were designed about the most crucial elements users would need to interact with.  The use case diagram can be seen in Figure 3.

<p align="center">
  <img src="./readmeFigures/useCase.PNG" width="300" title="useCase">
  <br>
  Figure 3: Use Case Diagram
</p>

These interactions were decided upon by asking a sample group of people what they would like to see from this type of app.  The most common things said amongst this group is being able to create their own recipe, having a calendar to see what recipe is when, and having an easy way to get a grocery list for any week so shopping is easier.  These are reflected by our choices in designing Figure 2.

### 3.3 Sequence Diagram

The three major interactions come from creating the recipes, linking those recipes to the date the user wants to make that recipe, and gathering the grocieries for a given week.  Figures 4 through 6 show the sequence diagrams for these interactions.

<p align="center">
  <img src="./readmeFigures/createRecipeSequence.PNG" width="300" title="createRecipe">
  <br>
  Figure 4: Sequence Diagram for Creating Recipes
</p>

<p align="center">
  <img src="./readmeFigures/linkRecipeSequence.PNG" width="300" title="linkRecipe">
  <br>
  Figure 5: Sequence Diagram for Creating Recipes
</p>

<p align="center">
  <img src="readmeFigures/getGrocerySequence.PNG" width="300" title="grocerySequence">
  <br>
  Figure 6: Sequence Diagram for Creating Recipes
</p>

## 4. User Guide / Implementation

## 5. Future Scope

## 6. Conclusion

## 7. Walkthrough
