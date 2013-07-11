As of Q3 2011 RadTextBox provides support for the new HTML5 input types. To leverage this functionality you can use the InputType property of the control.
You can set to the following values:

    Text - RadTextBox renders an input of type text and allows entering any type of string.
    Number - RadTextBox renders an input of type number and only numbers are recognized as valid entry.
    Date - RadTextBox renders an input of type date and lets the user enter only dates.
    Time - RadTextBox renders an input of type time and lets the user enter only time.
    DateTime - RadTextBox renders an input of type datetime and allows for specifying the time part of the DateTime object.
    E-mail- RadTextBox renders an input of type email. This type is used for input fields that should contain an e-mail address. 
    Tel-RadTextBox define a field for entering a telephone number. 

Note that not all browsers support HTML5 input types. Those which do not recognize the new input types currently behave as if the input is with type set to text.

You can see the browser support in the official W3C page below:
http://www.w3schools.com/html/html5_form_input_types.asp 