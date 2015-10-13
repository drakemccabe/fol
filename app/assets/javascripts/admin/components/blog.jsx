var blogValues = {
  title : null,
  category : null,
  author : null,
  image_url : null,
  body : null
}

var NewBlogPost = React.createClass({
  render: function() {
    return (
      <div>
        <h3>Create a New Blog Post</h3>
        <ul className="form-fields">
          <li>
            <label>Title</label>
            <input type="text" ref="title" defaultValue={this.props.blogValues.title} />
          </li>
          <li>
            <label>Category</label>
            <input type="text" ref="category" defaultValue={this.props.blogValues.category} />
          </li>
          <li>
            <label>Author</label>
            <input type="email" ref="author" defaultValue={this.props.blogValues.author} />
          </li>
          <li>
            <label>Image URL</label>
            <input type="text" ref="image_url" defaultValue={this.props.blogValues.image_url} />
          </li>
          <li>
            <label>Body</label>
            <input type="text" ref="body" defaultValue={this.props.blogValues.body} />
          </li>
          <li className="form-footer">
            <button className="btn -primary pull-right" onClick={this.nextStep}>Add Blog Post!</button>
          </li>
        </ul>
      </div>
    )
  },

  saveValues: function(blog_value) {
    return function() {
      blogValues = Object.assign({}, blogValues, blog_value)
    }.bind(this)()
  },

  submitPost: function() {
    $.ajax({
          type: "POST",
          beforeSend: function (request)
          {
            request.setRequestHeader("authorization", $authkey);
          },
          url: "//api.fol.dev/articles",
          contentType: "application/json; charset=utf-8",
          dataType: 'json',
          data: JSON.stringify({title: blogValues.title,
                                category: blogValues.category,
                                author: blogValues.author,
                                image_url: blogValues.image_url,
                                body: blogValues.body }),
          success: function() {
            for (var value in blogValues) blogValues[value] = null;

          }
      });
    },

  nextStep: function(e) {
    e.preventDefault()

    // Get values via this.refs
    var data = {
      title     : this.refs.title.getDOMNode().value,
      category : this.refs.category.getDOMNode().value,
      author    : this.refs.author.getDOMNode().value,
      image_url    : this.refs.image_url.getDOMNode().value,
      body    : this.refs.body.getDOMNode().value,
    }

    this.saveValues(data);
    this.submitPost();
  }
});

$( "#link6" ).click(function() {
  event.preventDefault();
  clearDiv()
  React.render(
    <div>
    <NewBlogPost blogValues={blogValues} />
    </div>,
    document.getElementById('table')
  )
});

function clearDiv() {
  React.unmountComponentAtNode(table)
  };
