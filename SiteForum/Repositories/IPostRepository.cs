using System;
using System.Collections.Generic;
using SiteForum.Exceptions;
using SiteForum.Model;

namespace SiteForum.Repositories
{
    /// <summary>
    /// Repository interface for <see cref="Post"/> objects.
    /// </summary>
    public interface IPostRepository
    {
        /// <summary>
        /// Gets the posts.
        /// </summary>
        /// <param name="from">Optional from date.</param>
        /// <param name="to">Optional to date.</param>
        /// <param name="label">Optional label.</param>
        /// <returns>Site forum posts which fulfill the criteria.</returns>
        IEnumerable<Post> GetPosts(DateTime? from, DateTime? to, string label);

        /// <summary>
        /// Add a new the forum post.
        /// </summary>
        /// <param name="post">The post.</param>
        /// <returns>Id of the new post object.</returns>
        int AddPost(Post post);

        /// <summary>
        /// Add comment to an existing forum post.
        /// </summary>
        /// <param name="postId">The post identifier.</param>
        /// <param name="comment">The comment.</param>
        /// <exception cref="PostNotFoundException">
        /// Throw when repository doesn't contain any forum post with the supplied id.
        /// </exception>
        /// <returns>Id of the new comment object.</returns>
        int AddComment(int postId, Comment comment);

        /// <summary>
        /// Delete a post by id.
        /// </summary>
        /// <param name="postId">The post identifier.</param>
        /// <exception cref="PostNotFoundException">
        /// Throw when repository doesn't contain any forum post with the supplied id.
        /// </exception>
        /// <remarks>Implement as a cascade delete for root objects. Delete all associated posts and comments added by the member.</remarks>        
        void DeletePost(int postId);
    }
}
