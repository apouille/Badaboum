$(document).ready(function() {

    // GLOBAL VARIABLES
    var filename = window.location.href.substr(window.location.href.lastIndexOf("/") + 1);
    var fileExtension = filename.substr((filename.lastIndexOf('.') + 0));
    var relativePath = window.location.href;

    filename = filename.replace(fileExtension, "");

    // Substring occurence in a string - returns number
    function occurrences(string, subString, allowOverlapping) {
        string += "";
        subString += "";
        
        if (subString.length <= 0) return (string.length + 1);

        var n = 0,
            pos = 0,
            step = allowOverlapping ? 1 : subString.length;

        while (true) {
            pos = string.indexOf(subString, pos);
            if (pos >= 0) {
                ++n;
                pos += step;
            } else break;
        }
        return n;
    }

    // STYLE SWITCHER
    $("#cmdShowStyleSwitcher").click(function() {
        if ($("#theme_style_switcher").hasClass("opened")) {
            $("body").removeClass("style-switcher-in");
            $("#theme_style_switcher").removeClass("opened");
        } else {
            $("body").addClass("style-switcher-in");
            $("#theme_style_switcher").addClass("opened");
        }
        return false;
    });

    // Default settings
	var styleSwitcher = $('#theme_style_switcher');

	// Set the default values used in custom.less
    var settings = styleSwitcher.data('settings'),
        theme_color = Cookies.get('theme_color') ? Cookies.get('theme_color') : settings[0].theme_color,
        theme_color_2 = Cookies.get('theme_color_2') ? Cookies.get('theme_color_2') : settings[0].theme_color_2,
        // theme_typeface_alt = Cookies.get('theme_typeface_alt') ? Cookies.get('theme_typeface_alt') : settings[0].theme_typeface_alt,
        // theme_typeface_base = Cookies.get('theme_typeface_base') ? Cookies.get('theme_typeface_base') : settings[0].theme_typeface_base;
        theme_border_radius = Cookies.get('theme_border_radius') ? Cookies.get('theme_border_radius') : '0.25rem';
        theme_card_border_radius = Cookies.get('theme_border_radius') ? Cookies.get('theme_border_radius') : '0.25rem';

	//Initialize LESS with default values
	less.modifyVars({
		'@color-base-1': theme_color,
        '@color-base-2': theme_color_2,
		// '@font-family-alt': theme_typeface_alt,
		// '@font-family-base': theme_typeface_base,
        '@border-radius': theme_border_radius,
        '@card-border-radius': theme_card_border_radius
	});

    function setThemeStyle(theme_style) {

        if(theme_style == "dark") {
            var stylesheet = $("#stylesheet").attr("href");
            stylesheet = stylesheet.replace("-dark", "");
            stylesheet = stylesheet.replace(".min", "");

            var parts = stylesheet.split("/");

            var result = parts[parts.length - 1]; // Or parts.pop();
            result = result.replace(".css", "");
            result = result.replace("-dark", "");

            stylesheet = stylesheet.replace(result, result + "-" + theme_style + '.min');

            $("#stylesheet").attr("href", stylesheet);

            Cookies.set('theme_style', theme_style);
        }

        else {
            Cookies.remove('theme_style');
            location.reload();
        }
    }

    $("[data-theme-switcher='theme-style'] a").click(function(){
        var $this = $(this);
        var value = $(this).data("value");

        setThemeStyle(value);

        return false;
    });

    Cookies.get('theme_style') ? setThemeStyle(Cookies.get('theme_style')) : '';

    // Theme color
    $("[data-theme-switcher='theme-color'] a").click(function(){
    	var $this = $(this);
    	var value = $(this).data("value");

    	// Create the new style with the selected values
		less.modifyVars({
            '@color-base-1': value,
            '@color-base-2': theme_color_2,
            // '@font-family-alt': theme_typeface_alt,
            // '@font-family-base': theme_typeface_base,
            '@border-radius': theme_border_radius,
            '@card-border-radius': theme_card_border_radius
        });

        // Save the new selected value in cookies
		Cookies.set('theme_color', value);

        // Mark the clicked elements as active
    	$("[data-theme-switcher='theme-color'] a").removeClass("active");
    	$("[data-theme-switcher='theme-color']").find('a[data-value="' + value + '"]').addClass("active");

    	return false;
    });

    // Mark the clicked elements as active on load
    $("[data-theme-switcher='theme-color']").find('a[data-value="' + theme_color + '"]').addClass("active");

    // Layout type
    function setLayoutType(layout_type) {
        if(layout_type != 0) {
            if(! $(".body-wrap").hasClass(layout_type)) {
                $(".body-wrap").removeClass("body-boxed");
                $(".body-wrap").addClass(layout_type);
            }
        } else {
            $(".body-wrap").removeClass("body-boxed");
        }

        $("[data-theme-switcher='layout-type'] input").each(function() {
            if($(this).val() == layout_type) {
                $(this).prop("checked", true);
            }
        })
    }

    $("[data-theme-switcher='layout-type'] input").change(function(){
        var $this = $(this);
    	var value = $(this).val();

        setLayoutType(value);

        // Save the new selected value in cookies
		Cookies.set('layout_type', value);
    });

    Cookies.get('layout_type') ? setLayoutType(Cookies.get('layout_type')) : '';

    // // BODY BACKGROUND
    $("#body_background a").click(function() {
        // Trigger click for boxed layout type
        $("#layout_type input[data-value='boxed']").trigger("click");

        var value = $(this).data("value");

        $("body").removeClass("body-bg-1 body-bg-2 body-bg-3 body-bg-4 body-bg-5 body-bg-6 body-bg-7 body-bg-8 body-bg-9");
        $("body").addClass(value);
        $("#body_background a").removeClass("active");
        $(this).addClass("active");

        Cookies.set('body_background', value);

        return false;
    });

    // Cookie reading
    var bodyBackground = Cookies.get('body_background');

    // Add active class to selected value button
    $("#body_background").find('a[data-value="' + bodyBackground + '"]').addClass("active");

    // Set option from cookie
    $("body").addClass(bodyBackground);


    $("#btnResetStyles").click(function() {
        // Cookies.remove('theme_typeface_base');
        // Cookies.remove('theme_typeface_alt');
        Cookies.remove('theme_style');
        Cookies.remove('theme_color');
        Cookies.remove('layout_type');
        Cookies.remove('body_background');
        location.reload();

        return false();
    });
});
