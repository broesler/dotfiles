Vim�UnDo� �<�ƀӕ��{Eg����f���M���RL��Q�                                    U�>    _�                             ����                                                                                                                                                                                                                                                                                                                                                             U�:    �                   �               5�_�                             ����                                                                                                                                                                                                                                                                                                                                                        U�>    �      	          
set hidden   if bufexists('$file')   !  exe ":buffer " . bufnr('$file')   else   9  edit ${file// /\ } " replace spaces with escaped spaces   endif   $line5��