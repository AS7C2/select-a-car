1. Open **DefaultWebConfiguration.swift**
2. Replace **baseURL** and **clientSecret** with actual values

- As a user, I want to be able to select a car, choosing a combination of manufacturer and model, and see a summary at the end. Each list will be provided through a web service.
- It should be implemented as two screens (manufacturer, model) with table views. When user selects row it goes to the next screen. When user selects row on the last screen it shows simple alert message with values selected on the previous screens.
-	Use custom cells. Even rows should have a different background color than odd rows.
-	As the web services can return a really long list of manufacturers and models, there should some pagination in the list. Page size: 15 elements.


![Manufacturers](https://raw.githubusercontent.com/AS7C2/select-a-car/master/Manufacturers.png)
![Models](https://raw.githubusercontent.com/AS7C2/select-a-car/master/Models.png)
![Selection](https://raw.githubusercontent.com/AS7C2/select-a-car/master/Selection.png)
