ccj_main_wrapper = function(graph_type, summarize_type=1, file_path="", locs=0){
    df <- get_tibble(file_path=file_path, locs=locs)
    var_names <- get_var_names(file_path=file_path, locs=locs)

    
    df <- switch(
        summarize_type, 
        get_group_mean_vals(df), 
        get_individual_mean_vals(df), 
        get_group_score(df), 
        get_individual_score(df)
    )
    return(
        switch(
            graph_type, 
            generate_bar(df,var_names),
            generate_facet(
                generate_scatter(df,var_names), var_names
            ),xx
            generate_densitity(df, var_names),
            generate_facet(
                generate_line(df, var_names), var_names
            )
    ))
}