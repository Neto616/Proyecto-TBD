const hbs = require('hbs')

hbs.registerHelper('controlVistaAdmin', (puesto) =>{
    return puesto === 'Admin' ? true : false
});

hbs.registerHelper('controlVistaInstituto', (puesto) =>{
    return puesto === 'Instituto' ? true : false
});

hbs.registerHelper('controlVistaAsesor', (puesto) =>{
    return puesto === 'Asesor' ? true : false
});

hbs.registerHelper('controlVistaJuez', (puesto) =>{
    return puesto === 'Juez' ? true : false
});
// Admin','Instituto','Asesor','Juez'