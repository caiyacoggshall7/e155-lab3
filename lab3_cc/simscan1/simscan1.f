-L work
-reflib pmi_work
-reflib ovi_ice40up


"C:/Users/ccoggshall/Desktop/e155lab3/lab3_cc/source/impl_1/top.sv" 
"C:/Users/ccoggshall/Desktop/e155lab3/lab3_cc/source/impl_1/keyscanner.sv" 
"C:/Users/ccoggshall/Desktop/e155lab3/lab3_cc/source/impl_1/slowclock.sv" 
"C:/Users/ccoggshall/Desktop/e155lab3/lab3_cc/source/impl_1/sevensegdisplay.sv" 
"C:/Users/ccoggshall/Desktop/e155lab3/lab3_cc/source/impl_1/synchronizer.sv" 
"C:/Users/ccoggshall/Desktop/e155lab3/lab3_cc/source/impl_1/debouncer.sv" 
"C:/Users/ccoggshall/Desktop/e155lab3/lab3_cc/source/impl_1/decoder.sv" 
"C:/Users/ccoggshall/Desktop/e155lab3/lab3_cc/source/impl_1/multiplex.sv" 
"C:/Users/ccoggshall/Desktop/e155lab3/lab3_cc/source/impl_1/keyscanner_tb.sv" 
-sv
-optionset VOPTDEBUG
+noacc+pmi_work.*
+noacc+ovi_ice40up.*

-vopt.options
  -suppress vopt-7033
-end

-gui
-top keyscanner_tb
-vsim.options
  -suppress vsim-7033,vsim-8630,3009,3389
-end

-do "view wave"
-do "add wave /*"
-do "run 100 ns"
