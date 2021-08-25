({

    init : function(component, event, helper) {
        console.log('>>> INIT <<<');
		helper.carregaBunkers(component, event);
        helper.setColumns(component);
	},

    handleChange: function (component, event, helper) {
        helper.selecionaBunker(component, event);
    },

    handleChangeCriatura: function (component, event, helper) {
        helper.recuperaCriaturaSelecionada(component, event);
    },

    incluirCriatura: function (component, event, helper) {
        helper.incluirCriaturaHelper(component, event);
    },

    viewRecord : function(component, event, helper) {
        helper.viewRecord( component, event );
	},

    showModal : function(component, event, helper) {
    
        helper.showModalHelper( component, event );
	},
    
    closeModal : function(component, event, helper) {
        helper.closeModalHelper( component, event );
	}

})