# tensorflow

## Graphs

There is always a default graph `tf.get_default_graph()`.

```python
graph = tf.Graph() # not thread-safe
with graph.as_default():
	x = tf.Variable(1, name="x")
```

## Sessions
```python
init = tf.global_variables_initializer()
with tf.Session() as sess:
	init.run()
```
