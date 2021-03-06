# tensorflow

## Graphs

There is always a default graph `tf.get_default_graph()`.

```python
graph = tf.Graph() # not thread-safe
with graph.as_default():
    x = tf.Variable(1, name='x')
```

## Sessions

```python
init = tf.global_variables_initializer()
with tf.Session() as sess:
    init.run()
```

## Save

```python
saver = tf.train.Saver()
with tf.Session() as sess:
    saver.restore(sess, 'model.ckpt')
    for epoch in range(num_epochs):
        if epoch % 10 == 0:
	        saver.save(sess, 'model.ckpt')
```

## Name Scopes

```python
with tf.name_scope('loss') as scope:
    error = y - t
    mse = tf.reduce_mean(tf.square(error), name='mse')
```
