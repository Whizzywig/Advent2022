(ns day6.core
  (:gen-class))

(defn Input []
  (with-open [reader (clojure.java.io/reader "input.txt")]
    (reduce conj [] (line-seq reader))))

(def line (slurp "input.txt"))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!")
  (println Input[0])
  (println line))