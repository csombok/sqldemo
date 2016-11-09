using System;

namespace SiteForum.Model
{
    public class Comment
    {
        public int Id { get; set; }
        public string Text { get; set; }
        public Member CreatedBy { get; set; }
        public DateTime TimeCreatedUtc { get; set; }
    }
}