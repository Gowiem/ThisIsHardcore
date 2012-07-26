Ext.override(Ext.form.TextArea, {
    adjustHeight: Ext.Function.createBuffered(function(textarea){
        var textAreaEl = Ext.getCmp(textarea.id).getComponent().input;
        if (textAreaEl) {
            textAreaEl.dom.style.height = 'auto';
            textAreaEl.dom.style.height = textAreaEl.dom.scrollHeight + "px";
        }


    },200,this),


    constructor: function() {
        this.callParent(arguments);


        this.on({
            scope: this,
            keyup: function (textarea) {
                textarea.adjustHeight(textarea);
            },
            change: function(textarea, newValue) {
                textarea.adjustHeight(textarea);
            },
			painted: function(textarea) {
				textarea.adjustHeight(textarea);
			}
        });
    }
});