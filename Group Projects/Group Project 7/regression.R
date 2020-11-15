#' Runs a full regression test and saves the information to a csv
#' @param one (tibble) the starting tibble
#' @param repo (tibble) the joined tibble
#' @export a joined, cleaned and pivioted tibble
gen_model <- function(regression, title, comp=F){
    pdf(paste(title, ".pdf", sep=""))
    
    grid <- sim1a %>%
    data_grid(x) %>%
    add_predictions(regression)

    plot <- ggplot(sim1a, aes(x)) + 
        geom_point(aes(y=y)) +
        geom_point(data = grid, aes(y=pred), color="blue") +
        ggtitle(title)

    if(comp){
        secondary <- ggplot(sim1a, aes(x)) + 
            geom_point(aes(y=y)) +
            geom_smooth(data = grid, aes(y=pred), color="blue") +
            ggtitle(title)
        
        plot <- grid.arrange(
            plot,
            secondary,
            nrow=1
        )
    }

    print(
        plot
    )

    sim1a <- sim1a %>%
    add_residuals(regression)

    plot <- ggplot(sim1a, aes(resid)) +
        geom_freqpoly(binwidth=0.5) +
        ggtitle(title)

    print(
       plot
    )
    

    plot <- ggplot(sim1a, aes(x,resid)) +
        geom_point() +
        geom_ref_line(h=0) +
        ggtitle(title)

    if(comp){
        secondary <- ggplot(sim1a, aes(x,resid)) +
        geom_smooth() + 
        geom_ref_line(h=0) +
        ggtitle(title)

        plot <- grid.arrange(
            plot,
            secondary,
            nrow=2
        )
    }

    print(
        plot
    )

    dev.off()
}
