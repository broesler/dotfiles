" Align macro
let @a='i\begin{align}\end{align}k'

" bar matrix macro
let @b='a\begin{m€kbbmatrix} \end{bmatrix}Bh'

" Equation macro
let @e='i\begin{equation}\end{equation}k'

" Figure macro
let @f='o\begin{figure}[h!]
      \\centering
      \\includegraphics[width=\textwidth]{pinned_bar_modes.pdf}
      \\caption{First few vibrational mode shapes of a pinned-pinned bar.}
      \\label{fig:modeshapes}
      \0i\end{figure}'

" Subfigure macro
let @s='o\begin{figure}[h!]
      \\centering
      \  \begin{subfigure}[c]{0.45\textwidth}
      \\centering
      \\includegraphics[width=\textwidth]{state_errorr.pdf}
      \\caption{Linear error vs.\ time plot.}
      \\end{subfigure}
      \0i  \hspace{0.1cm}
      \  \begin{subfigure}[c]{0.45\textwidth}
      \\centering
      \\includegraphics[width=\textwidth]{state_errorr_semilog.pdf}
      \\caption{Semilog error vs.\ time plot.}
      \\end{subfigure}
      \0i  \caption{Two error plots to compare linear and semilog plot. The semilog plot shows $|e(k)|$ for ease of determining the order of convergence.}
      \\label{fig:error_r1}
      \0i\end{figure}'

" Table macro
let @t='o\begin{table}[h!]
      \\setlength{\tabcolsep}{8pt}
      \\def\arraystretch{1.1}
      \\caption{Coefficient of variation of thrust and side force for the data presented in \citet{Broering2012c}}
      \\label{tab:broering}
      \\begin{center}
      \  \begin{tabular}{l r r}
      \\firsthline
      \\multicolumn{1}{c}{case} & \multicolumn{1}{c}{$\Upsilon_T$} & \multicolumn{1}{c}{$\Upsilon_S$} \\ \hline
      \single foil         &    1.0800  &    4.8324  \\
      \  $\phi =   0\deg$  &    0.9593  &    4.4851  \\
      \  $\phi =  90\deg$  &    1.4826  &    5.7911  \\
      \  $\phi = 180\deg$  &    1.0644  &    5.7090  \\
      \\lasthline
      \0i\end{tabular}
      \0i  \end{center}
      \0i\end{table}'
