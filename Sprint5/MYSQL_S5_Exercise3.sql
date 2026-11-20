-- Task 1
create index idx_booking_dates on booking (check_in_date,check_out_date);

-- Task 2
-- Task 2: Improved with Composite Index
CREATE INDEX idx_property_loc_price ON property(location);
select * from review;
-- Task 3: Improved with Rating and Full-Text search
CREATE INDEX idx_review_rating1 ON review(rating);
CREATE FULLTEXT INDEX idx_review_feedback ON review(review_text);