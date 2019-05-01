library(keras)
FLAGS <- flags(
  flag_numeric("dropout1", 0.4),
  flag_numeric("dropout2", 0.3),
  flag_integer("units1", 128),
  flag_integer("units2", 64),
  flag_integer("bs", 32),
  flag_integer("epochs", 100),
  flag_numeric("lr", 1e-3)
)

model <- keras_model_sequential()
model %>%
  layer_dense(units = FLAGS$units1, activation = 'relu', input_shape = c(49)) %>%
  layer_dropout(FLAGS$dropout1) %>%
  layer_dense(units = FLAGS$units2, activation = 'relu') %>%
  layer_dropout(FLAGS$dropout2) %>%
  layer_dense(units = 10, activation = 'softmax')
model %>% compile(
  loss = 'sparse_categorical_crossentropy',
  # optimizer = optimizer_rmsprop(lr=1e-2, rho=0.9, decay=0.05),
  # optimizer=optimizer_adam(),
  optimizer=optimizer_rmsprop(lr=FLAGS$lr),
  metrics=c('accuracy')
)
model %>% fit(
  as.matrix(dat.500.2[,-50]), as.matrix(dat.500.2$train.labels),
  batch_size = FLAGS$bs,
  epochs = FLAGS$epochs,
  verbose = 0,
  # shuffle = TRUE,
  # validation_split = 0.2
  validation_data=list(test.images.scaled.mat, test.labels)
)

