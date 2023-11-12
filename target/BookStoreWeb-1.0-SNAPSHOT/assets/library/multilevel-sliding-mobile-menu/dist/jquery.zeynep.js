/*!
 * zeynepjs v1.0.2
 * A light-weight multi-level jQuery side menu plugin.
 *
 * Author: Huseyin Elmas
 */
(function($) {
    var pluginName = 'zeynep';
    var defaults = {
        initialized: false,
        disableTransition: false,
        width: 295,
        onLoading: null,
        onLoad: null,
        onOpening: null,
        onOpened: null,
        onClosing: null,
        onClosed: null,
        onUnloading: null,
        onUnloaded: null
    };

    function Plugin(element, options) {
        this.element = element;
        this.options = $.extend({}, defaults, options);
        this._defaults = defaults;
        this._name = pluginName;
        this.eventController = eventController;
        this.init();
    }
    Plugin.prototype.init = function() {
        var zeynep = this.element;
        var submenuTriggers = zeynep.find('[data-submenu]');
        var options = this.options;
        if (options.initialized) return;
        this.eventController('onLoading');
        this.element.css('transform', 'translateX(-' + this.options.width + 'px)');
        this.element.css('width', this.options.width);
        submenuTriggers.each(function() {
            var _this = $(this);
            var subMenuId = _this.attr('data-submenu');
            var submenuEl = $('#' + subMenuId);
            if (!submenuEl.length) return true;
            _this.on('click', function(event) {
                var scrollTop = submenuEl.parents('.submenu:first').scrollTop() || 0;
                if (!zeynep.find('.submenu.opened').length) {
                    zeynep.css('overflow-y', 'hidden');
                    scrollTop = zeynep.scrollTop();
                }
                submenuEl.parents('.submenu:first').css('overflow-y', 'hidden');
                submenuEl.scrollTop(0);
                submenuEl.css('top', scrollTop);
                submenuEl.css('transform', 'translateX(0)');
                submenuEl.addClass('opened');
            });
            submenuEl.find('[data-submenu-close="' + subMenuId + '"]').on('click', function(event) {
                submenuEl.parents('.submenu:first').css('overflow-y', '');
                submenuEl.css('transform', 'translateX(' + options.width + 'px)');
                submenuEl.removeClass('opened');
                if (!zeynep.find('.submenu.opened').length) {
                    zeynep.css('overflow-y', '');
                }
            });
        });
        options.initialized = true;
        this.eventController('onLoad');
    };
    Plugin.prototype.open = function() {
        this.eventController('onOpening');
        var html = $('html');
        var body = $('body');
        this.options.disableTransition && this.element.add(html).addClass('no-transition');
        html.addClass('zeynep-opened');
        this.element.css('transform', 'translateX(0)');
        body.css('left', this.options.width);
        this.eventController('onOpened');
    };
    Plugin.prototype.close = function(disableEvent) {
        !disableEvent && this.eventController('onClosing');
        var html = $('html');
        var body = $('body');
        html.removeClass('zeynep-opened');
        body.css('left', 0);
        this.element.css('transform', 'translateX(-' + this.options.width + 'px)');
        this.options.disableTransition && this.element.add(html).removeClass('no-transition');
        !disableEvent && this.eventController('onClosed');
    };
    Plugin.prototype.unload = function() {
        this.eventController('onUnloading');
        this.close(true);
        this.element.removeAttr('style');
        this.element.find('.submenu.opened').removeClass('opened');
        this.element.find('.submenu').removeAttr('style');
        $('body').css('left', '');
        this.element.removeData(pluginName);
        this.eventController('onUnloaded');
        this.options = this._defaults;
        zeynep = null;
        delete zeynep;
    };
    var eventController = function(type) {
        if (!this.options[type] || typeof this.options[type] !== 'function') return;
        switch (type) {
            case 'onLoading':
                this.options.onLoading.call();
                break;
            case 'onLoad':
                this.options.onLoad.call();
                break;
            case 'onOpening':
                this.options.onOpening.call();
                break;
            case 'onOpened':
                this.options.onOpened.call();
                break;
            case 'onClosing':
                this.options.onClosing.call();
                break;
            case 'onClosed':
                this.options.onClosed.call();
                break;
            case 'onUnloading':
                this.options.onUnloading.call();
                break;
            case 'onUnloaded':
                this.options.onUnloaded.call();
                break;
        }
    };
    var getInstance = function(element, options) {
        var _instance = null;
        var _options = options || {};
        if (!element.data(pluginName)) {
            _instance = new Plugin(element, _options);
            element.data(pluginName, _instance);
        } else {
            _instance = element.data(pluginName);
        }
        return _instance;
    };
    $.fn[pluginName] = function(options) {
        var zeynep = this;
        if (zeynep.length > 1) return null;
        var instance = getInstance(zeynep, options);
        return {
            open: function() {
                instance.open.apply(instance);
            },
            close: function() {
                instance.close.apply(instance);
            },
            unload: function() {
                instance.unload.apply(instance);
            }
        };
    }
})(window.jQuery);