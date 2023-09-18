# install.packages("randomForest")
library(randomForest)

#=====If you have your own data==
dataset <- read.csv("your_data_set")

bip <- dataset %>% 
  filter((is.na(ExitSpeed) != T | is.na(ExitSpeed) != T) & PitchCall == "InPlay") %>% 
  mutate(woba = case_when(PlayResult == "Single" ~ 0.9,
                          PlayResult == "Double" ~ 1.25,
                          PlayResult == "Triple" ~ 1.6,
                          PlayResult == "HomeRun" ~ 2,
                          PlayResult != "Single" | PlayResult != "Double" | PlayResult != "Triple" | PlayResult != "HomeRun" ~ 0 
  )) %>% 
  select(ExitSpeed,Angle)
#=====Try the example data=======

bip <- read.csv("example_data.csv")

#================================

X <- bip[, c("ExitSpeed", "Angle")]
y <- bip$woba


set.seed(42)  
train_indices <- sample(1:nrow(bip), 0.8* nrow(bip))
X_train <- X[train_indices, ]
y_train <- y[train_indices]
X_test <- X[-train_indices, ]
y_test <- y[-train_indices]

rf_model <- randomForest(x = X_train, y = y_train, ntree = 100)

X_test$xwoba <- predict(rf_model, newdata = X_test)

# Eye test: Enter some exit velos and launch angles and see if it makes sense
new_batted_balls <- data.frame(ExitSpeed = c(3, 120, 92), Angle = c(10, 20 ,32))
new_batted_balls$xwoba <- predict(rf_model, newdata = new_batted_balls)
print(new_batted_balls)

# Create a heat map
ggplot(X_test %>% arrange(xwoba),aes(x = ExitSpeed, y = Angle, color = xwoba)) +
  geom_point(size = 3) +scale_color_gradient2(high = ("red"),
                                              mid = "white",
                                              low = ("blue"),
                                              midpoint = 1,) +
  labs(title = "Heat Map of Predicted Values", x = "x", y = "y")

# If the model looks good, save it for later
save(rf_model,file = "your_path")
