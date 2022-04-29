datos.url <-"cd_catalog.xml"
datos.doc <- xmlParse(datos.url)
rootNode <- xmlRoot(datos.xml)
root.node[1]
datos.data <- xmlSApply(root.node, function(x) xmlSApply(x, xmlValue))
datos.datos <- data.frame(t(datos.data), row.names = NULL)