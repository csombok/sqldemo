using System;
using System.Collections.Generic;

namespace SiteForum.Model
{
    public class Post
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public Member CreatedBy { get; set; }
        public DateTime TimeCreatedUtc { get; set; }
        public IEnumerable<Comment> Comments { get; set; }
        public IEnumerable<ContentLabel> Labels { get; set; }
    }
}