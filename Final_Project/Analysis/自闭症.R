library(RWeka)
library(data.table)
library(DT)
# 整理数据 去掉一些不要的列
dat.autism.child=read.arff("../Autism/Autism-Child-Data.arff")
dat.autism.adolescent=read.arff("../Autism/Autism-Adolescent-Data.arff")
dat.autism.adult=read.arff("../Autism/Autism-Adult-Data.arff")
setDT(dat.autism.child)
setDT(dat.autism.adolescent)
setDT(dat.autism.adult)
dat.autism.child[,c("result","age_desc","relation"):=list(NULL,NULL,NULL)]
dat.autism.adolescent[,c("result","age_desc","relation"):=list(NULL,NULL,NULL)]
dat.autism.adult[,c("result","age_desc","relation"):=list(NULL,NULL,NULL)]



# imputation
# dat.autism.child[ethnicity==NA] ???? 不行
age.na.index=which(is.na(dat.autism.child$age))
eth.na.index=which(is.na(dat.autism.child$ethnicity))
tot.na.index=unique(c(age.na.index,eth.na.index))
dat.autism.child[tot.na.index, .N, by=`Class/ASD`] # 健康29 病人15  剪掉 #健康122 病人126

age.na.index=which(is.na(dat.autism.adolescent$age))
eth.na.index=which(is.na(dat.autism.adolescent$ethnicity))
tot.na.index=unique(c(age.na.index,eth.na.index))
dat.autism.adolescent[tot.na.index, .N, by=`Class/ASD`] # 健康5 病人1 剪掉 #健康36 病人62

age.na.index=which(is.na(dat.autism.adult$age))
eth.na.index=which(is.na(dat.autism.adult$ethnicity))
tot.na.index=unique(c(age.na.index,eth.na.index))
dat.autism.adult[tot.na.index, .N, by=`Class/ASD`] # 健康86 病人9 剪掉 #健康429 病人180

# fix.vars=c("age","gender","ethnicity","jundice","austim","contry_of_res","used_app_before")
# for (var in fix.vars){
#   print(dat.autism.child[, unique(get(var))])
# }

dat.autism.child[,.N,by=`Class/ASD`] # 151健康 141病人
dat.autism.adolescent[,.N,by=`Class/ASD`] # 41健康 63病人
dat.autism.adult[,.N,by=`Class/ASD`] # 515健康 189病人  不均！！！

# 查看NA ethnicity有很多缺失！age只有一点点其他都没缺
dat.autism.child[,lapply(.SD, FUN = function(x){return(sum(is.na(x)))})]
dat.autism.adolescent[,lapply(.SD, FUN = function(x){return(sum(is.na(x)))})]
dat.autism.adult[,lapply(.SD, FUN = function(x){return(sum(is.na(x)))})]
a[,lapply(.SD, FUN = function(x){return(sum(is.na(x)))})]

# 有没有一个人缺3个及以上的？没有
dat.reduce.child=dat.autism.child[,c(11:17)]
any(dat.reduce.child[, rowSums(is.na(.SD))]>=3)
dat.reduce.adolescent=dat.autism.adolescent[,c(11:17)]
any(dat.reduce.adolescent[, rowSums(is.na(.SD))]>=3)
dat.reduce.adult=dat.autism.adult[,c(11:17)]
any(dat.reduce.adult[, rowSums(is.na(.SD))]>=3)






