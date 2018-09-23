#######################################
#----------Predictive Model-----------#
#######################################
library(caret)
library(Metrics)
library(xgboost)

dtt[, ":"(foldid = .I %/% 6 + 1), by = .(outcome)] #model training 


# Create custom summary function in proper format for caret
custom_summary <- function(data, lev = NULL, model = NULL){
  out = rmsle(data[, "obs"], data[, "pred"])
  names(out) = c("rmsle")
  out
}

# Create control object
control <- trainControl(method = "cv",  # Use cross validation
                        number = 5,     # 5-folds
                        summaryFunction = custom_summary                      
)


# Create grid of tuning parameters
grid <- expand.grid(nrounds=c(100, 200, 400, 800), # Test 4 values for boosting rounds
                    max_depth= c(4, 6),           # Test 3 values for tree depth
                    eta=c(0.1, 0.05, 0.025),      # Test 3 values for learning rate: 0.1, 0.05, 0.025
                    gamma= c(0.1),                #https://xgboost.readthedocs.io/en/latest/parameter.html for explanation
                    colsample_bytree = c(1), 
                    min_child_weight = c(1),
                    subsample = c(1))

#training and development of model

xgb_tree_model <- train(SalePrice~.,      # Predict SalePrice using all features
                        data=train,
                        method="xgbTree",
                        trControl=control, #for cross validation w control
                        tuneGrid=grid, 
                        metric="rmsle",     # Use custom performance metric
                        maximize = FALSE)   # Minimize the metric

#Analysis of results
xgb_tree_model$bestTune #tells us the best model, is a tree with depth 4, trained 400 rounds w learning rate 0.1 (eta)
xgb_tree_model$results #find the RMSLE from the above model here: RMSLE = 0.1327114; the lower the better!


varImp(xgb_tree_model) #identify which predictors are most impt to the model

#testing of dataset

test_predictions <- predict(xgb_tree_model, newdata=test)

submission <- read.csv("sample_submission.csv")
submission$SalePrice <- test_predictions
write.csv(submission, "home_prices_xgb_sub1.csv", row.names=FALSE)