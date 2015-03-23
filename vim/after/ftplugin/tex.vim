" Align macro
let @a='i\begin{align}\end{align}k'

" bar matrix macro
let @b='a\begin{m€kbbmatrix} \end{bmatrix}Bh'

" Equation macro
let @e='i\begin{equation}\end{equation}k'

" Figure register (just "fp for figure template)
let @f='\begin{figure}[h!]
      \    \centering
      \    \includegraphics[width=\textwidth]{pinned_bar_modes.pdf}
      \    \caption{First few vibrational mode shapes of a pinned-pinned bar.}
      \    \label{fig:modeshapes}
      \\end{figure}'

" Subfigure register (just "sp for subfigure template)
let @s='\begin{figure}[h!]
      \ 	\centering
      \ 	\begin{subfigure}[c]{0.45\textwidth}
      \ 		\centering
      \ 	     \includegraphics[width=\textwidth]{state_errorr.pdf}
      \ 	\caption{Linear error vs.\ time plot.}
      \ 	\end{subfigure}
      \ 	\hspace{0.1cm}
      \ 	\begin{subfigure}[c]{0.45\textwidth}
      \ 		\centering
      \ 		\includegraphics[width=\textwidth]{state_errorr_semilog.pdf}
      \ 	\caption{Semilog error vs.\ time plot.}
      \ 	\end{subfigure}
      \\caption{Two error plots to compare linear and semilog plot. The semilog plot shows $|e(k)|$ for ease of determining the order of convergence.}
      \\label{fig:error_r1}
      \\end{figure}'

