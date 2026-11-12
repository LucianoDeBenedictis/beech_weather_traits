# Custom DAG plot ---------------------------------------------------------

#based on rethinking's drawdag with more customization
#by Richard McElreath https://github.com/rmcelreath/rethinking
#GPL v3 https://github.com/rmcelreath/rethinking/blob/master/DESCRIPTION

mydag <- function (x,
                   col_arrow = "black",
                   col_segment = "black",
                   col_labels = "black", 
                   cex = 1,
                   lwd = 1.5,
                   goodarrow = TRUE,
                   xlim, ylim,
                   shapes,
                   xbuffer_adj = 1,
                   ybuffer_adj = 1,
                   col_shapes,
                   radius = 3.5,
                   add = FALSE,
                   latent_mark = "c",
                   arr.width = 0.15,
                   arr.length = 0.2) {
  coords <- coordinates(x)
  if (any(!is.finite(coords$x) | !is.finite(coords$y))) {
    coords <- coordinates(graphLayout(x))
  }
  labels <- names(x)
  if (add == FALSE) {
    par(mar = rep(0, 4))
    plot.new()
    par(new = TRUE)
  }
  wx <- sapply(paste0("mm", labels), function(s) strwidth(s, 
                                                          units = "inches"))
  wy <- sapply(paste0("\n", labels), function(s) strheight(s, 
                                                           units = "inches"))
  ppi.x <- dev.size("in")[1]/(max(coords$x) - min(coords$x))
  ppi.y <- dev.size("in")[2]/(max(coords$y) - min(coords$y))
  wx <- wx/ppi.x
  wy <- wy/ppi.y
  if (missing(xlim)) 
    xlim <- c(min(coords$x - wx/2), max(coords$x + wx/2))
  if (missing(ylim)) 
    ylim <- c(-max(coords$y + wy/2), -min(coords$y - wy/2))
  if (add == FALSE) 
    plot(NA, xlim = xlim, ylim = ylim, xlab = "", ylab = "", 
         bty = "n", xaxt = "n", yaxt = "n")
  unobs_vars <- latents(x)
  if (length(unobs_vars) > 0 & !is.null(latent_mark)) {
    if (missing(shapes)) 
      shapes <- list()
    for (uv in unobs_vars) {
      if (is.null(shapes[[uv]])) 
        shapes[[uv]] <- latent_mark
    }
  }
  xxbuffer <- strwidth("xx") * xbuffer_adj
  yybuffer <- strheight("\n") * ybuffer_adj
  wx <- sapply(labels, function(s) strwidth(s, cex = cex) + xxbuffer)
  wy <- sapply(labels, function(s) max(strheight(s, cex = cex), yybuffer))
  
  xlabels <- lapply(labels, function(l) {
    lr <- l
    xx <- strsplit(l, "_")[[1]]
    if (length(xx) > 1) {
      lr <- bquote(.(xx[1])[.(xx[2])])
    }
    return(lr)
  })
  
  names(wx) <- labels
  names(wy) <- labels
  if (length(unobs_vars) > 0 & !is.null(latent_mark)) {
    circle_w <- strwidth("M", cex = radius)
    circle_h <- strheight("M", cex = radius)
    wx[unobs_vars] <- circle_w
    wy[unobs_vars] <- circle_h
  }
  asp <- par("pin")[1]/diff(par("usr")[1:2])/(par("pin")[2]/diff(par("usr")[3:4]))
  ex <- dagitty::edges(x)
  ax1 <- rep(0, nrow(ex))
  ax2 <- rep(0, nrow(ex))
  ay1 <- rep(0, nrow(ex))
  ay2 <- rep(0, nrow(ex))
  axc <- rep(0, nrow(ex))
  ayc <- rep(0, nrow(ex))
  acode <- rep(2, nrow(ex))
  has.control.point <- rep(FALSE, nrow(ex))
  for (i in seq_len(nrow(ex))) {
    if (ex[i, 3] == "<->") {
      acode[i] <- 3
      has.control.point[i] <- TRUE
    }
    if (ex[i, 3] == "--") {
      acode[i] <- 0
    }
    l1 <- as.character(ex[i, 1])
    l2 <- as.character(ex[i, 2])
    x1 <- coords$x[l1]
    y1 <- coords$y[l1]
    x2 <- coords$x[l2]
    y2 <- coords$y[l2]
    if (is.na(ex[i, 4]) || is.na(ex[i, 5])) {
      cp <- dagitty:::.autoControlPoint(x1, y1, x2, y2, 
                                        asp, 0.2 * as.integer(acode[i] == 3))
    }
    else {
      cp <- list(x = ex[i, 4], y = ex[i, 5])
      has.control.point[i] <- TRUE
    }
    bi1 <- dagitty:::.lineSegBoxIntersect(x1 - wx[l1]/2, 
                                          y1 - wy[l1]/2, x1 + wx[l1]/2, y1 + wy[l1]/2, x1, 
                                          y1, cp$x, cp$y)
    bi2 <- dagitty:::.lineSegBoxIntersect(x2 - wx[l2]/2, 
                                          y2 - wy[l2]/2, x2 + wx[l2]/2, y2 + wy[l2]/2, cp$x, 
                                          cp$y, x2, y2)
    if (length(bi1) == 2) {
      x1 <- bi1$x
      y1 <- bi1$y
    }
    if (length(bi2) == 2) {
      x2 <- bi2$x
      y2 <- bi2$y
    }
    ax1[i] <- x1
    ax2[i] <- x2
    ay1[i] <- y1
    ay2[i] <- y2
    axc[i] <- cp$x
    ayc[i] <- cp$y
  }
  directed <- acode == 2 & !has.control.point
  undirected <- acode == 0 & !has.control.point
  arr.type <- "curved"
  arr.adj <- 1
  if (goodarrow == TRUE) {
    if (!requireNamespace("shape", quietly = TRUE)) {
      stop(
        "Please install package shape to run this function.\n",
        "`install.packages(\"shape\")`"
      )
    }
    shape::Arrows(ax1[directed], -ay1[directed], ax2[directed], 
                  -ay2[directed], arr.length = arr.length, arr.width = arr.width, 
                  col = col_arrow, lwd = lwd, arr.adj = arr.adj, arr.type = arr.type)
  }
  else arrows(ax1[directed], -ay1[directed], ax2[directed], 
              -ay2[directed], length = arr.length, col = col_arrow, lwd = lwd)
  segments(ax1[undirected], -ay1[undirected], ax2[undirected], 
           -ay2[undirected], col = col_segment, lwd = lwd)
  for (i in which(has.control.point)) {
    dag_arc(ax1[i], -ay1[i], ax2[i], -ay2[i], axc[i], -ayc[i], 
            col = c(col_arrow, col_segment)[1 + (acode[i] == 
                                                   0)], code = acode[i], length = 0.1, lwd = lwd + 
              (acode[i] == 0), goodarrow = goodarrow)
  }
  if (!missing(shapes)) {
    if (length(shapes) > 0) {
      for (i in 1:length(shapes)) {
        the_label <- names(shapes)[i]
        j <- which(labels == the_label)
        if (missing(col_shapes)) 
          col_shapes <- col_labels[min(j, length(col_labels))]
        if (length(j) > 0) {
          cpch <- 1
          if (shapes[[i]] == "fc") 
            cpch <- 16
          if (shapes[[i]] %in% c("c", "fc")) 
            points(coords$x[the_label], -coords$y[the_label], 
                   cex = radius, lwd = lwd, col = col_shapes, 
                   pch = cpch)
        }
      }
    }
  }
  for (i in 1:length(xlabels)) {
    k <- if(length(col_labels) == 1) col_labels else col_labels[i]
    text(coords$x[i], -coords$y[labels][i], xlabels[[i]], 
         cex = cex, col = k)
  }
  arrtab <- data.frame(ax1, ay1, ax2, ay2, directed)
  return(invisible(arrtab))
}

# Rao function with abundances --------------------------------------------

#inputs are a n*s matrix with samples as rows and species as columns and distance matrix
#it is convenient to have sp. names as colnames and dimnames respectively

rao <- function(dat, distances, equivalent = F, species = NULL){
  #a few data checks
  stopifnot(is.matrix(dat), is.matrix(distances),
            dim(distances)[1] == dim(distances)[2],
            !any(distances < 0),
            identical(colnames(distances), rownames(distances)))
  if (is.null(species)) {
    species <- colnames(dat)
  }
  if (is.null(species)) {
    stop("must provide species either as colnames or as vector")
  }
  if (!all(species %in% colnames(distances)))
    stop("data contains species not in distance matrix")
  dat <- dat[rowSums(dat)>0, ] #drops empty samples
  distances <- distances[species, species] #reorder distances same as data
  rao <- apply(dat, 1, function(x)
    crossprod(x, distances %*% x), simplify = T)
  if (equivalent)
    return(1/(1-rao))
  else
    return(rao)
}

# distswap ----------------------------------------------------------------

#randomizes the symmetric trait distance matrix

distswap <- function (x, n) {
  if ((dim(x)[1] != dim(x)[2]) & length(dim(x)) != 2){
  stop("This is not a square matrix.")
  }
  perm <- function (x) {
  x[lower.tri(x)] <- sample(x[lower.tri(x)], replace = F) #permute lower triangle
  x[upper.tri(x)] <- t(x[lower.tri(x)]) # copy to upper triangle
  return(x)
  }
  rando <- replicate(n, perm(x)) #array of permuted dissims, z is the rand n.
  return(rando)
  }

# SESrao ------------------------------------------------------------------

#calculates SES from matrix permutations
#species and dissim are observed species and dissimilarities
#rand is an array of permuted species or dissimilarity matrices
#function can handle subsetting if rand comes from regional pool while dissim is global

if (!requireNamespace("datawizard", quietly = TRUE)) {
  stop(
    "Please install package datawizard to run this function.\n",
    "`install.packages(\"datawizard\")`"
  )
}

SESrao <- function(species, dissim, rand, which, equivalent = F) {
  which <- match.arg(which, c("species", "dissim"))
  obs <- rao(species, dissim, equivalent)
  
  if (!is.array(rand) || length(dim(rand)) != 3) {
    stop("rand must be a 3D array.")
  }
  
  if (which == "dissim") {
    if (!identical(dim(dissim), dim(rand)[-3])) {
      message(sprintf("dissim dimensions (%d, %d) don't match first two dimensions of rand (%d, %d). Will subset dissim using names", 
                   nrow(dissim), ncol(dissim), dim(rand)[1], dim(rand)[2]))
      dissim <- dissim[rownames(rand), colnames(rand)]
    }
    sim <- apply(rand, 3, function(x) rao(species, x, equivalent))
  } else {  # which == "species"
    if (!identical(dim(species), dim(rand)[-3])) {
      message(sprintf("species dimensions (%d, %d) don't match first two dimensions of rand (%d, %d). Will subset species using names", 
                   nrow(species), ncol(species), dim(rand)[1], dim(rand)[2]))
      species <- species[, colnames(rand)]
    }
    sim <- apply(rand, 3, function(x) rao(x, dissim, equivalent))
  }
  
  if (is.vector(sim)) { #edge-case with one randomization
    sim <- matrix(sim, nrow = length(sim), ncol = 1)
  }
  
  if (!identical(dim(sim), c(nrow(species), dim(rand)[3]))) {
    stop("Simulated values have unexpected dimensions")
  }
  
  mean <- rowMeans(sim)
  sd <- apply(sim, 1, sd)
  SES <- ifelse(sd == 0, NA, (obs - mean) / sd)
  skews <- apply(sim, 1, datawizard::skewness)
  skews <- sapply(skews, function(x) x[[1]])
  cat("Skewness of random distributions:\n")
  print(summary(skews))
  return(SES)
}

# melodic ------------------------------------------

#de Bello et al. 2016, «Functional Diversity through the Mean Trait Dissimilarity: Resolving Shortcomings with Existing Paradigms and Algorithms»

##MEan DIssimilarity Components##
#samp:  community matrix; sites in lines, species in columns
#dis:   dissimilarity matrix
#type:  "both" for results with abundances weighted and non-weighted
#       "abundance" for results with abundances weighted
#       "presence" for results with abundances non-weighted

melodic <- function(samp,dis,type="both"){
  #if(class(samp)!="matrix"){samp <- as.matrix(samp)}
  #if(class(dis)!="matrix"){dis <- as.matrix(dis)}
  if(is.null(colnames(samp)) | is.null(colnames(dis)) ){
    stop("Both samp and dis must have colnames.\n")
  }
  N<-dim(samp)[1]
  melodic<-list()
  if (type=="both"){
    melodic$abundance<-list()
    melodic$abundance$mpd<-melodic$abundance$rao<-melodic$abundance$simpson<-numeric(N)
    melodic$presence<-list()
    melodic$presence$mpd<-melodic$presence$rao<-melodic$presence$simpson<-numeric(N)
  }
  if (type=="abundance"){ 
    melodic$abundance<-list()
    melodic$abundance$mpd<-melodic$abundance$rao<-melodic$abundance$simpson<-numeric(N)
  }
  if (type=="presence"){ 
    melodic$presence<-list()
    melodic$presence$mpd<-melodic$presence$rao<-melodic$presence$simpson<-numeric(N)
  }
  for (i in 1:N){
    sppInSample<-names(samp[i,samp[i, ]>0])
    melodic$richness[i]<-rowSums(samp>0)[i]
    if (length(sppInSample)>1){
      sample.dis<-dis[sppInSample,sppInSample]
      abund.w<-numeric(length(sppInSample))
      if (type=="both" | type=="abundance"){
        abund.w <- samp[i , sppInSample] / sum(samp[i , sppInSample])
        sample.weights <- outer(abund.w , abund.w)
        melodic$abundance$mpd[i] <- weighted.mean(sample.dis[lower.tri(sample.dis)] , sample.weights[lower.tri(sample.weights)])
        melodic$abundance$rao[i] <- sum(sample.weights * sample.dis)
        melodic$abundance$simpson[i] <- sum(2*sample.weights[lower.tri(sample.weights)])
      } 	
      if (type=="both" | type=="presence"){
        abund.nw <- rep(1 , length(sppInSample)) / length(sppInSample)
        sample.weights <- outer(abund.nw , abund.nw)
        melodic$presence$mpd[i] <- weighted.mean(sample.dis[lower.tri(sample.dis)] , sample.weights[lower.tri(sample.weights)])
        melodic$presence$rao[i] <- sum(sample.weights * sample.dis)
        melodic$presence$simpson[i] <- sum(2*sample.weights[lower.tri(sample.weights)])
      }	
    }	else {
      if (type=="both" | type=="abundance"){
        melodic$abundance$mpd[i] <- NA
        melodic$abundance$rao[i] <- melodic$abundance$simpson[i] <-0
      }
      if (type=="both" | type=="presence"){
        melodic$presence$mpd[i] <- NA
        melodic$presence$rao[i] <- melodic$presence$simpson[i] <-0
      }
    }
  }  	
  out<-melodic
  return(out)	
}


# distribution plot function ----------------------------------------------

histdensity <- function(data, var, bins = 10, adjust = 1)  {
  data |> 
    ggplot(aes(x = {{var}}))+
    geom_histogram(aes(y=after_stat(density)), color = "white", bins=bins)+
    geom_density(aes(y=after_stat(density)), color = "red", adjust = 1)
}


# Box-Cox transformation --------------------------------------------------

boxcox <- function(x, check = F) {
  
  if (any(na.omit(x) <= 0)) {
    shift <- abs(min(na.omit(x))) + 1
    message("Non-positive values detected. Shifting ", deparse(substitute(x)), 
            " by ", shift, " to make it strictly positive.")
    x <- x + shift
  }
  
  boxcox_result <- MASS::boxcox(x ~ 1, plotit = F)
  lambda <- boxcox_result$x[which.max(boxcox_result$y)]
  
  message("Box-Cox transform with lambda = ", lambda)
  
  if (check == T) return(lambda)
  else{
    if (abs(lambda) < 0.1) {
      x <- log(x)
    } else {
      x <- (x ^ lambda - 1) / lambda
    }
    return(x)
  }
}

# subplots ----------------------------------------------------------------

#SUs are numbered sequentially row by row, starting from the upper left corner
#this function aggregates them in adjacent squares

subplots <- function(x, scale = 2){
  #scale is the side length of the new aggregation
  if (max(x) %% (scale^2) != 0){
    stop("SUs must be a multiple of scale^2")
  }
  side <- sqrt(max(x)) # side length of the grid
  if (side != floor(side)) stop("x is not a square grid")
  x <- x - 1 # start from 0 instead of 1
  ints <- x %/% side # int. div. gives the row  
  mods <- x %% side # modulo, gives the column of each SU
  R <- ints %/% scale # gives the row on the final grid
  C <- mods %/% scale # gives the column on the final grid
  index <- R * (side / scale) + C # index on the final grid
  return(index + 1) # start from 1 for consistency
}

# Plot fitted -------------------------------------------------------------

# This function plots median and probability envelope for the expected value of the outcome against the weather variable, together with the original data points. Although the data points are coloured by site, the prediction is on the average not conditioned by site, so a perfect fit isn't to be expected.
# It must be noted that, since the regression is performed on scaled predictors, those predictors are scaled back only after computing the predictions (this gives the correct outcome, since the regression coefficients are based on the scaled predictors).

plot_fitted <- function(fit, dat, ind1 = NULL, ind2 = NULL, dep = NULL,
                        wt = NULL, sm = F, pred_range = 0.5,
                        range_1 = NULL, range_2 = NULL,
                        pal = NULL, fill = "#637180", shape = 1,
                        max_size = 4, res_x = 20, res_rib = 100){
  
  #generic function to iterate on variable pairs
  plot_fitted_ <- function(ind, range, interact = NULL){
    #get which dependent and independent variable
    if(is.null(dep)){
    dep <- fit[["formula"]][["resp"]]
    }
    if(is.null(ind)){
    ind <- names(fit$data)[!grepl("^(site|cover|mean|above|below|overall)", names(fit$data))]
    if(length(ind) > 1) stop("Must be a single independent variable")
    }
    
    ind_raw_n <- str_remove(ind, "_centered")
    ind_sd_n <- str_c(ind_raw_n, "_sd")
  
    #if ind is centered, calculate grand mean
    ind_mean <- if(str_detect(ind, "_centered")){
      ind_site_n <- str_c(ind_raw_n, "_site")
      mean(tapply(dat[[ind_site_n]], fct_drop(dat$site), mean))
    } else 0
    
    ind_sd <- if(ind_sd_n %in% names(dat)){
      dat |> 
        select(matches(ind_sd_n)) |> 
        pluck(1, 1)
    } else 1
    
    #if dep is scaled, get sd for rescaling
    dep_sd_n <- str_c(dep, "_sd")
    dep_sd <- if(dep_sd_n %in% names(dat)){
      dat |> select(matches(dep_sd_n)) |> pluck(1, 1)
    } else 1
    
    #range for predictions
    if(is.null(range)){
      from <- floor(min(dat[[ind_raw_n]])) - pred_range
      to <- ceiling(max(dat[[ind_raw_n]])) + pred_range
    } else {
      if(length(range) != 2) stop("Ranges must be length 2.")
      from <- range[1] / ind_sd
      to <- range[2] / ind_sd
    }
    #avoid negative precipitation, clamp at raw 0
    if (str_detect(ind_raw_n, "prec") && from < 0) from <- 0
    
    nd <- tibble("{ind}" := seq(from - ind_mean, to - ind_mean,
                                length.out = res_x),
                 site = NA)
    
    #add cover if present
    if("cover" %in% names(fit$data)){
      cov_mean <- mean(tapply(dat$cover, fct_drop(dat$site), mean))
      nd <- nd |> 
        mutate(cover = cov_mean)
    }
  
    #second variable to interact
    nd <- if(!is.null(interact)){
      nd |>
        expand_grid("{interact}" := c(-1, 0, 1))
    } else {
      others <- setdiff(names(fit$data), c(dep, names(nd))) |> 
        str_subset("centered$")
      missing <- rep(0, length(others)) |> 
        set_names(others)
      nd |> 
        mutate(!!!missing)
    }
    
    #add prediction and rescale axes
    nd <- nd |> 
      add_epred_draws(fit) |> 
      #put fitted regression on original scale
      mutate("{ind}" := (.data[[ind]] + ind_mean) * ind_sd,
             .epred = .epred * dep_sd)
    #put original data back on original scale
    dat <- dat |> 
      mutate("{ind}" := .data[[ind_raw_n]] * ind_sd,
             "{dep}" := .data[[dep]] * dep_sd)
    
    #if sm = T, label which points appear where
    if(sm && !is.null(interact)){
      dat <- dat |> 
        mutate(panel = factor(findInterval(.data[[interact]], c(-0.5, 0.5)) - 1,
                              levels = c(-1, 0, 1)))
      }
    
    #plotting function
    plot_fun <- function(x, pts = dat){
      
      point_aes <- if(is.null(wt)){
        aes(x = .data[[ind]], y = .data[[dep]], color = site)
      } else {
        aes(x = .data[[ind]], y = .data[[dep]], color = site, size = .data[[wt]])
      }
      
      plot <- x |> 
        ggplot(aes(x = .data[[ind]], y = .epred)) +
        # plot prediction interval quantiles as continuous shade
        # idea from https://solomon.quarto.pub/sr2/08.html
        # adapted according to ggdist manual
        stat_lineribbon(aes(fill_ramp = after_stat(.width)),
                        .width = ppoints(res_rib),
                        point_interval = "median_qi",
                        fill = fill,
                        alpha = 0.5,
                        linewidth = 0.7) +
        scale_fill_ramp_continuous(range = c(1, 0),
                                   from = "white",
                                   breaks = 1:3*.25,
                                   name = "Width",
                                   guide = guide_rampbar(to = fill)) +
        #plot original data on top
        geom_point(point_aes,
                   data = pts,
                   shape = shape,
                   show.legend = c(colour = T, 
                                   fill_ramp = F,
                                   size = F)) +
        scale_size_area(max_size = max_size) +
        coord_cartesian(ylim = range(dat[[dep]]),
                        expand = c(T, F, T, F))
      
      if(is.null(pal)){
        plot +
          scale_color_brewer(palette = "Dark2", name = "Site", drop = F)
      } else {
        plot +
          scale_color_manual(name = "Site", values = palette_pred, drop = T)
      }
    }
    
    if(!is.null(interact)){
      int_raw_n <- str_remove(interact, "_centered")
      
      unit <- case_when(str_detect(int_raw_n, "air|soil") ~ " °C",
                        str_detect(int_raw_n, "prec") ~ " mm")
      
      int_sd <- dat |> 
        select(matches(str_c(int_raw_n, "_sd"))) |> 
        pluck(1, 1) |> 
        round(1) |> 
        str_c(unit)
      
      nicer <- int_raw_n |> 
        replace_when(str_detect(int_raw_n, "air") ~ "air temperature",
                     str_detect(int_raw_n, "soil") ~ "soil temperature")
      
      labels <- str_c(c("- ", "Site mean ", "+ "), c(int_sd, nicer, int_sd))
      
      nd_split <- split(nd, nd[[interact]])
      
      plots <- if(sm){
        pts_split <- split(dat, dat$panel)[names(nd_split)]
      
        map2(nd_split, pts_split, plot_fun)
      } else {
        map(nd_split, plot_fun)
      }
      return(plots |> 
               set_names(labels))
    } else plot_fun(nd)
  }
  if(is.null(ind2)){
    plot_fitted_(ind1, range_1)
  } else {
    c(plot_fitted_(ind1, range_1, ind2),
      plot_fitted_(ind2, range_2, ind1))
  }
}

# Customized MCMC pairs ---------------------------------------------------

my_mcmc_pairs <- function(x, pars = vars(!c(lprior, lp__, b_Intercept))){
  mcmc_pairs(x, 
             pars = pars,
             np = nuts_params(x),
             off_diag_fun = "hex")
}


# Trace rank plot ---------------------------------------------------------

trank <- function(x){
  #for multiple imputation, it makes no sense to show together chains from different imputations
  if(any(str_detect(class(x), "multiple"))){
    x |> 
      as_draws_df() |>
      as.data.frame() |> 
      mutate(imp = (.chain - 1) %/% 4,
             Chain = (.chain - 1) %% 4 +1) |>
      select(!.chain:.draw) |> 
      group_by(imp) |> 
      group_split(.keep = F) |> 
      map(\(t) mcmc_rank_overlay(t, pars = show)) |> 
      wrap_plots(ncol = 2, axes = 'collect', guides = 'collect') &
      theme(axis.text.x = element_blank(),
            axis.text.y = element_blank())
  }
  #regular plot
  else{
    x |>
      as_draws_array() |>
      mcmc_rank_overlay(pars = show)
  }
}


# Multiple convergence ----------------------------------------------------

# Convergence diagnostics can't be calculated on multiply imputed datasets. Instead, they are calculated for each imputation, and then we keep the worst for each parameter:

multiple_convergence <- function(fit, m = 5, chains = 4){
  indices <- map(0:(m - 1), \(x) seq(1 + chains * x, chains * x + chains))
  
  draws <- as_draws_array(fit)

  map(indices, \(x) posterior::subset_draws(draws, chain = x)) |> 
    map(\(x) summarise_draws(x, posterior::default_convergence_measures())) |> 
    bind_rows() |> 
    summarise(rhat = max(rhat),
              ess_bulk = min(ess_bulk),
              ess_tail = min(ess_tail),
              .by = "variable") |> 
    filter(!variable %in% c("lprior", "lp__"))
}


# custom conditional effects ----------------------------------------------

#this modification to conditional_effects shows predictions and conditions at +-1 SD, instead of the observed range and SD
my_ceffects <- function(x, hurdle = F, ...){
  effects <- variables(x) |> 
    str_subset("air|prec|soil") |> 
    str_remove("^b_")
  
  if(hurdle){
    effects <- effects |> 
      str_subset("hu_", negate = T)
  }
  
  interaction <- effects |> 
    str_subset(":")
  
  int_v1 <- interaction |> 
    str_extract("^.*(?=:)")
  
  int_v2 <- interaction |> 
    str_extract("(?<=:).*$")
  
  effects <- setdiff(effects, interaction)
  
  interaction2 <- str_c(int_v2, ":", int_v1)
  
  walk(effects,
       \(y) conditional_effects(x, y, int_conditions = list(seq(-1, 1, length.out = 100)) |> 
                                  set_names(y), ...) |> 
         plot(ask = F))
  
  conditional_effects(x, interaction, int_conditions = list(seq(-1, 1, length.out = 100),-1:1) 
                      |> set_names(c(int_v1, int_v2)), ...) |> 
    plot(ask = F)
  
  conditional_effects(x, interaction2, int_conditions = list(seq(-1, 1, length.out = 100),-1:1) 
                      |> set_names(c(int_v2, int_v1)), ...) |> 
    plot(ask = F)
}
