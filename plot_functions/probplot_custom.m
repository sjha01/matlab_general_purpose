% --- help for probplot_custom ---
% 
% Probability plot - plot sorted input data's expected quantiles for a given
% distribution against the sorted input data. Same as MATLAB's probplot, but
% with more customization options.
% 
% Inputs
% ------
% x : double vec
%     Vector with data to be plotted.
% 
% 'reference_line' = true : Boolean, optional
%     Indicator of whether to plot reference line in addition to data.
% 
% 'grid_on' = 'on' : char vec, optional
%     Indicator of whether to plot with grid on.
% 
% 'point_size' = 6 : double, optional
%     Size of data points.
% 
% 'point_color' = 'r' : char_vec or double_arr, optional
%     Color or colormap for data points.
% 
% 'line_width' = 1 : double, optional
%     Width of reference line.
% 
% 'line_color' = 'k' : char_vec or double_arr, optional
%     Color of reference line.
% 
% 'line_style' = '--' : char_vec, optional
%     Style of reference line.
% 
% 'plot_title' = 'Probability plot for Normal distribution' : char vec,
%   optional
%     Title of probability plot.
% 
% 'plot_x_label' = 'Data' : char vec, optional
%     x-axis label for probability plot.
% 
% 'plot_y_label' = 'Probability' : char vec, optional
%     y-axis label for probability plot.
% 
% Outputs
% -------
% None
% 
% Examples
% --------
% x = normrnd(20.0, 6.0, [1 100]);
% figure;
% probplot_custom(x);
% 
% See also
% --------
% probplot
% 
% 

% Notes
% -----
% 1. MATLAB probplot documentation: https://www.mathworks.com/help/releases/R2017b/stats/probplot.html#d119e599292
% 2. Useful post: https://www.mathworks.com/matlabcentral/answers/287080-how-are-the-fitted-line-and-the-y-axis-probabilities-levels-within-probplot-computed
% 
% Improvements
% ------------
% 1.  Currently, for normal distribution only. Extend for other types of
%     distributions.
% 2. Error checking.
% 

function probplot_custom(x, varargin)
    
    pnames = {'reference_line', 'grid_on', ...
        'point_size', 'point_color', ...
        'line_width', 'line_color', 'line_style', ...
        'plot_title', 'plot_x_label', 'plot_y_label'};
    dflts  = {true, 'on', ...
        6, 'r', ...
        1, 'k', '--', ...
        'Probability plot for Normal distribution', 'Data', 'Probability'};
    
    [reference_line, grid_on, ...
        point_size, point_color, ...
        line_width, line_color, line_style, ...
        plot_title, plot_x_label, plot_y_label] = internal.stats.parseArgs(pnames, dflts, varargin{:});
    
    hold_state = ishold;
    
    x = sort(x);
    f = arrayfun(@(f_i) (f_i - 0.5) / (length(x)), 1:length(x));
    f = reshape(f, size(x));
    x_model = norminv(f, 0, 1);

    q = 4;
    % x_q = quantile(x, q ); % what I expected from documentation
    x_q = quantile(x, q - 1);
    % f_q = arrayfun(@(f_i) (f_i - 0.5) / q, 1:q); %  what I expected from documentation 
    f_q = arrayfun(@(f_i) (f_i - 0.0) / q, 1:q);
    x_model_q = norminv(f_q, 0, 1);
    fit_1 = polyfit([x_q(1) x_q(3)], [x_model_q(1) x_model_q(3)], 1);

    ticks_f = [0.05 0.10 0.25 0.50 0.75 0.90 0.95];
    % extra elements in ticks_f if enough of distribution is in very low
    % quantiles.
    if min(f) < 0.01
        ticks_f_min = min(f);
        ticks_f_min = floor(log(ticks_f_min) / log(10));
        if ticks_f_min < -2
            ticks_f_extra = ticks_f_min:-3;
            ticks_f_extra = union(arrayfun(@(item) 5*10^item, ticks_f_extra), arrayfun(@(item) 10^(item + 1), ticks_f_extra));
            ticks_f = union(ticks_f, ticks_f_extra);
        end
    end
    
    ticks_x_model = norminv(ticks_f, 0, 1);
    % ticks_labels = arrayfun(@(item) num2str(item, '%0.2f'), ticks_f, 'UniformOutput', false);
    ticks_labels = cell(size(ticks_f));
    for i = 1:length(ticks_f)
        if ticks_f(i) >= 0.01
            ticks_labels{i} = num2str(ticks_f(i), '%0.2f');
        else
            ticks_labels{i} = num2str(ticks_f(i), '%10.0e');
        end
    end
    % disp(class(ticks_labels));
    %for i = 1:length(ticks_labels)
    %    if ticks_f(i) < 0.01
    %end
    
    % disp(size(x));
    % disp(point_size);
    scatter3(x, x_model, ones(size(x)), point_size * ones(size(x)), point_color, 'filled');
    
    if strcmp(grid_on, 'on')
        grid on;
    elseif strcmp(grid_on, 'off')
        grid off;
    else
        error('Input ''grid on'' must be either ''on'' or ''off''');
    end
    
    if reference_line
        hold on;
        x_limits = get(gca, 'XLim');
        y_limits = get(gca, 'YLim');
        x_range = max(x) - min(x);
        x_plot = [min(x) - x_range / 2.0, max(x) + x_range / 2.0];
        plot(x_plot, fit_1(1) * x_plot + fit_1(2), line_color, 'LineWidth', line_width, 'LineStyle', line_style);
        hold off;
        xlim(x_limits);
        ylim(y_limits);
    end
    yticks(ticks_x_model);
    yticklabels(ticks_labels);
    title('Probability plot for Normal distribution');
    xlabel('Data');
    ylabel('Probability');

    view(0, 90);
    
    if hold_state
        hold on;
    else
        hold off;
    end

end
