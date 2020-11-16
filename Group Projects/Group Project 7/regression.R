#' Runs a full regression test and saves the information to a pdf if requested
#' @param df (tibble) containg value1 and value2 where value1 is the X and value2 is the Y
#' @param regression (object) the regression algoirthm alread applied to the 
#' @param regression_formula_str (string) the formula as a string for labs
#' @param val1_str (string) the string that represents value 1
#' @param val2_Str (string) the string that represents value 2
#' @param pdf (string) when set this will save the graphs as that file name
#' @param smooth_comp (bool) if set to True will add a geom smooth to each approapriate graph in a grid
#' @export a joined, cleaned and pivioted tibble
gen_model <- function(df, regression, grid, regression_formula_str='A regression Model', val1_str="X", val2_str="Y", pdf='', smooth_comp=F){
    if(pdf != ''){
        pdf(paste(pdf, ".pdf", sep=""))
    }

    plot <- ggplot(df, aes(x)) + 
        geom_point(aes(y=y)) +
        geom_point(data = grid, aes(y=pred), color="orange") +
        labs(
            title = paste(regression_formula_str, " 1", sep=""),
            subtitle = paste(val1_str, " vs ", val2_str, sep=""),
            x = val1_str,
            y = val2_str
        )
    if(smooth_comp){
        secondary <- ggplot(df, aes(x)) + 
            geom_point(aes(y=y)) +
            geom_smooth(data = grid, aes(y=pred), color="orange") +
            ggtitle(title) +
            labs(
                title = paste("Smooth Compare 1", sep=""),
                subtitle = paste(val1_str, " vs ", val2_str, sep=""),
                x = val1_str,
                y = val2_str
            )
        
        plot <- grid.arrange(
            plot,
            secondary,
            nrow=1
        )
    }

    print(
        plot
    )

    df <- df %>%
    add_residuals(regression)

    plot <- ggplot(df, aes(resid)) +
        geom_freqpoly(binwidth=0.5) +
        ggtitle(title) +
        labs(
            title = paste(regression_formula_str, " Residuals", sep=""),
            subtitle = paste(val1_str, " vs ", val2_str, sep=""),
            x = val1_str,
            y = val2_str
        )

    print(
       plot
    )
    

    plot <- ggplot(df, aes(x,resid)) +
        geom_point() +
        geom_ref_line(h=0) +
        ggtitle(title) +
        labs(
            title = paste(regression_formula_str, " Residual Test", sep=""),
            subtitle = paste(val1_str, " vs ", val2_str, sep=""),
            x = val1_str,
            y = val2_str
        )

    if(smooth_comp){
        secondary <- ggplot(df, aes(x,resid)) +
        geom_smooth() + 
        geom_ref_line(h=0) +
        ggtitle(title) +
        labs(
            title = paste(regression_formula_str, " Residual Test Geom_Smooth Comparison", sep=""),
            subtitle = paste(val1_str, " vs ", val2_str, sep=""),
            x = val1_str,
            y = val2_str
        )

        plot <- grid.arrange(
            plot,
            secondary,
            nrow=2
        )
    }

    print(
        plot
    )

    if(pdf != ''){
        dev.off()
    }
}
