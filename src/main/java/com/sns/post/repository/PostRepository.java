package com.sns.post.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sns.post.entity.PostEntity;

public interface PostRepository extends JpaRepository<PostEntity, Integer> {

}
