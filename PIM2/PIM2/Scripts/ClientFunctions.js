var reExtraneous = new RegExp("[`,¬,¦,!,\",£,$,€,%,&,*,=,{,},;,:,#,~,|,<,>,?,^]");

function hasNoExtraneousChars(str) {
    try {
        var bolValid = false;

        if (reExtraneous.test(str) == false)
        { bolValid = true; }
        else
        { bolValid = false; }

        return bolValid;
    }
    catch (exception) {
        return false;
    }
}

function isNumeric(value) {
    try {
        var bolNumeric = false;

        if (isNaN(parseFloat(value)))
        { bolNumeric = false; }
        else
        { bolNumeric = true; }

        return bolNumeric;
    }
    catch (exception) {
        return false;
    }
}

