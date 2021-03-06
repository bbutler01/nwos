#' NWOS Proportion
#'
#' This function calculates means for NWOS replicates. This is typically used with an apply function.
#' @usage nwos_proportion_apply(r, index.rep, data, weight.rep, owner.area.name = "OWNER", domain.name, base.name = "FFO", variable.name = "FFO")
#' @param r vector of replicates numbers.
#' @param index.rep list of observations (i.e., replicates) to include.
#' @param index vector used to identify the location of values in the other vectors (e.g., row names).
#' @param weight list of weights for each observation in each replicate.
#' @param area vector of the area (of forestland) for each observation. Default = 1.
#' @param domain vector with 1 indicating inclusion in the domain and 0 otherwise. Default = 1.
#' @param variable vector of variable of interest.
#' @return Mean of variable of interest.
#'  @keywords nwos
#' @seealso nwos_mean
#' @export
#' @details
#' This function needs to be run by stratum (e.g., family forest ownerships in a state).
#' Due to indexing (to allow for apply function), there are fewer defauly values than nwos_mean.
#' @references
#' Butler, B.J. In review. Weighting for the US Forest Service, National Woodland Owner Survey. U.S. Department of Agriculture, Forest Service, Northern Research Station. Newotwn Square, PA.
#' @examples
#' wi <- tbl_df(read.csv("data/wi.csv")) %>% mutate(ROW_NAME = row.names(wi), AC_WOOD = ACRES_FOREST, FFO = if_else(LAND_USE == 1 & OWN_CD == 45 & AC_WOOD >= 1, 1, 0), RESPONSE = if_else(RESPONSE_PROPENSITY >= 0.5, 1, 0), RESPONSE = if_else(is.na(RESPONSE_PROPENSITY), 0, RESPONSE))
#' WI_REPLICATES <- nwos_replicates(index = row.names(wi), point.count = wi$POINT_COUNT, R = 100)
#' WI_FFO_AREA_REP <- sapply(WI_REPLICATES, nwos_stratum_area_apply, index = wi$ROW_NAME, stratum = wi$FFO, state.area = 33898733)
#' WI_FFO_RR_REP <- sapply(WI_REPLICATES, nwos_response_rate_apply, index = wi$ROW_NAME, stratum = wi$FFO, response = wi$RESPONSE)
#' WI_FFO_WEIGHTS_REP <- lapply(1:length(WI_REPLICATES), nwos_weights_apply,index.rep = WI_REPLICATES, index = wi$ROW_NAME, stratum = wi$FFO, response = wi$RESPONSE, area = wi$AC_WOOD,stratum.area = WI_FFO_AREA_REP, response.rate = WI_FFO_RR_REP)
#' WI_FFO_OWN_AC_MEAN <- nwos_mean(weight = wi$WEIGHT, variable = wi$AC_WOOD)
#' WI_FFO_OWN_AC_MEAN_REP <- sapply(1:length(WI_REPLICATES), nwos_mean_apply, index.rep = WI_REPLICATES, index = wi$ROW_NAME, weight = WI_FFO_WEIGHTS_REP, variable = wi$AC_WOOD)
#' WI_FFO_OWN_AC_MEAN
#' sqrt(var(WI_FFO_OWN_AC_MEAN_REP))
#' WI_FFO_AC_AC_MEAN <- nwos_mean(weight = wi$WEIGHT, area = wi$AC_WOOD, variable = wi$AC_WOOD)
#' WI_FFO_AC_AC_MEAN_REP <- sapply(1:length(WI_REPLICATES), nwos_mean_apply, index.rep = WI_REPLICATES, index = wi$ROW_NAME, weight = WI_FFO_WEIGHTS_REP, area = wi$AC_WOOD, variable = wi$AC_WOOD)
#' WI_FFO_AC_AC_MEAN
#' sqrt(var(WI_FFO_AC_AC_MEAN_REP))

nwos_mean_apply <- function(r, index.rep, index, weight, area = 1, domain =1, variable) {
  index.rep <- unlist(index.rep[r])
  if(length(area) != 1) area <- area[match(index.rep, index)]
  if(length(domain) != 1) domain <- domain[match(index.rep, index)]
  nwos_total(weight = unlist(weight[r]), area = area, domain = domain, variable = variable[match(index.rep, index)]) /
    nwos_total(weight = unlist(weight[r]), area = area, domain = domain, variable = 1)
}
